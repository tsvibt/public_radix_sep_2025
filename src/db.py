
from src.shared_state import DB
from src.utilities import *
from src.classes import *

from diskcache import Index
from itertools import islice

import brotli
import pickle 
import io
#https://grantjenks.com/docs/diskcache/api.html#diskcache.Index.items
#https://grantjenks.com/docs/diskcache/tutorial.html

_G_Server_module_name = 'src.site.server'
_G_Server_Unpickle = (__name__ == _G_Server_module_name)
class Unpickler(pickle.Unpickler):
   def find_class(self, module, name):
      if _G_Server_Unpickle and module == "__main__":
         module = _G_Server_module_name
      return super().find_class(module, name)

def Unpickle(byte_string): return Unpickler(io.BytesIO(byte_string)).load()
def Pickle(obj)          : return pickle.dumps(obj)

def Uncompress(string): return brotli.decompress(string)
def Compress(string)  : return brotli.compress(string, quality=1)


class Disk_DB:
   def __init__(self, directory):
      self.directory, self.stem = directory, directory.split('/')[-2]
      print(f'opening database in directory: {directory}')

      self.tables = [Disk_Table(self, *table_spec) for table_spec in DB_TABLE_SPECS]
      for table in self.tables: setattr(self, table.name, table)

   def __getstate__(self): return self.directory
   def __setstate__(self, directory): self.__init__(directory)

   def real_table_names(self): return [table.name for table in self.tables]


DB_DELIMITER = '\x1f\x1d'

class Disk_Table:
   def __init__(self, db, name, batchsize=100):# see notes 30000):
      if name[0] != '_': raise Exception(f'tried to make table named {name} but tables should start with "_".')
      self.db, self.name, self.directory, self.batchsize = db, name, f'{db.directory}{name}/', batchsize
      self._cached_index = None

      self._cached_aux1 = None
      self._cached_aux2 = None

      self.name_of_cacheget = f'{self.db.stem}{self.name}_CACHE_Get'
      self.CACHE_Get = GLOBALCACHES.CACHIFY(lambda *args: self.Get(*args), self.name_of_cacheget)
      self.CACHE     = GLOBALCACHES[self.name_of_cacheget]

      self.insert_queue = []
      self.dict_queue = []
      self.set_queue = []
      self.appenddict_queue = {}

      def unpack_types(key_cols)         : return [*key_cols[0]] + list(key_cols[1:])
      def repack_types(operator, length) : return lambda key_cols: [operator(*key_cols[:length])] + list(key_cols[length:])
      match self.name.split('_', 2)[1]:
         case 'GRAM' : key_lens = (unpack_types , repack_types(Gram, 2))
         case 'WORD' : key_lens = (unpack_types , repack_types(Word, 3))
         case _      : key_lens = (IDENTITY     , IDENTITY)
      self.Plainkey_DBkey = lambda plain_key: DB_DELIMITER.join(key_lens[0](plain_key))
      self.DBkey_Plainkey = lambda db_key   : key_lens[1](db_key.split(DB_DELIMITER))

      self.DBval_SET = self.Plainval_DBval(set())
      self._cached_OneValue = None

   def index(self):
      if self._cached_index is None: self._cached_index = Index(self.directory) 
      return self._cached_index

   def aux1(self):
      if self._cached_aux1 is None: self._cached_aux1 = Index(self.directory + 'aux1/') 
      return self._cached_aux1

   def aux2(self):
      if self._cached_aux2 is None: self._cached_aux2 = Index(self.directory + 'aux2/') 
      return self._cached_aux2

   def __reduce__(self): return f'DB.{self.name}'

   def Plainval_DBval(self, x) : return Compress(Pickle(x))
   def DBval_Plainval(self, x) : return Unpickle(Uncompress(x)) if x is not None else None

   def PlainRow_DBPair(self, row): return (self.Plainkey_DBkey(row[:-1]), self.Plainval_DBval(row[-1]))

   def KeyItem_QueueAppenddict(self, key, item):
      #maybe should be list and append, not sure...
      self.appenddict_queue.setdefault(self.Plainkey_DBkey((key,)), set()).add(item)

   def Execute_AppendictUpdates(self):
      if len(self.appenddict_queue) == 0: return 

      dbkey_aux1index = {}
      with self.aux1().transact():
         for db_key in self.appenddict_queue.keys(): 
            dbkey_aux1index[db_key] = (aux1index := self.aux1().get(db_key, 0))
            self.aux1()[db_key] = aux1index + 1

      appenddict = {DB_DELIMITER.join([k, str(dbkey_aux1index[k])]):self.Plainval_DBval(v) for k,v in self.appenddict_queue.items()}
#      with self.aux2().transact():
      self.aux2().update(appenddict)

#      with self.index().transact():
#         for db_key, value in self.appenddict_queue.items(): 
#            self.index()[db_key] = self.Plainval_DBval(value | self.DBval_Plainval(self.index().get(db_key, self.DBval_SET)))

      self.appenddict_queue = {}

   def Dict_QueueDict(self, dictionary): 
      self.dict_queue.append(dictionary)
      if len(self.dict_queue) > self.batchsize: self.Execute_DictUpdates()

   def Execute_DictUpdates(self):
      if len(self.dict_queue) == 0: return 
      merged_db_dict = {self.Plainkey_DBkey((k,)):self.Plainval_DBval(v) for k,v in Dicts_Union(self.dict_queue).items()}
      self.index().update(merged_db_dict)
      self.dict_queue = []

   def Row_QueuePair(self, row): 
      self.insert_queue.append(self.PlainRow_DBPair(row))
      if len(self.insert_queue) > self.batchsize: self.Execute_RowInsertions()

   def Execute_RowInsertions(self):
      if len(self.insert_queue) == 0: return 
      with self.index().transact():
         for key, value in self.insert_queue: 
            self.index()[key] = value
      self.insert_queue = []

   def InsertRow(self, row): self.Row_QueuePair(row); self.Execute_RowInsertions()

   def Set_QueueSet(self, items): 
      self.set_queue.append(items)
      if len(self.set_queue) > self.batchsize: self.Execute_SetUpdates()

   def Execute_SetUpdates(self):
      if len(self.set_queue) == 0: return 
      merged_db_set = {self.Plainkey_DBkey((item,)): self.Plainval_DBval('') for item in unionfold(self.set_queue)}
      self.index().update(merged_db_set)
      self.set_queue = []

   def Execute_all_updates(self): self.Execute_RowInsertions(); self.Execute_DictUpdates(); self.Execute_SetUpdates(); self.Execute_AppendictUpdates()

   def Get(self, *args)        : return self.DBkey_Get(self.Plainkey_DBkey(args))
   def DBkey_Get(self, db_key) : return self.DBval_Plainval(self.index().get(db_key))
   def DBkey_Row(self, db_key) : return [*self.DBkey_Plainkey(db_key), self.DBkey_Get(db_key)]

   def BatchGet(self, plain_keys, cache=True) : 
      db_keys = [self.Plainkey_DBkey(key) for key in plain_keys if key not in self.CACHE]
      with self.index().transact():
         results = [(db_key, self.index().get(db_key)) for db_key in db_keys]
      return [(self.DBkey_Plainkey(db_key), self.DBval_Plainval(value)) for db_key, value in results] + \
            [(key, value) for key in plain_keys if (value := self.CACHE.get(key, None))]

   def DBkeyIterator(self): return iter(self.index().keys())
#   def KeySet(self): return set(self.index().keys())
   def SetIterator(self): 
      for db_key in self.index().keys(): yield self.DBkey_Plainkey(db_key)[0]

   def RowIterator(self):
      for key, value in self.index().items():
         yield [*self.DBkey_Plainkey(key), self.DBval_Plainval(value)]

   def Drop(self) : self.index().clear()
   def Count(self)       : return len(self.index())
   def OneValue(self):
      if not self._cached_OneValue: self._cached_OneValue = self.Get(ONE_KEY)
      return self._cached_OneValue

   def ALLCACHE(self, to_print=True):
      if to_print: print(f'getting all rows for table {self.name} from db {self.db.stem}')
      if to_print: print('done getting all rows for table', self.name)
      if to_print: print('adding all rows to cache for table', self.name)
      GLOBALCACHES[self.name_of_cacheget].clear() # preserve references to this object
#      GLOBALCACHES[self.name_of_cacheget] = {}
##XXX
      for i, (key, value) in enumerate(self.index().items()):
         GLOBALCACHES[self.name_of_cacheget][tuple(self.DBkey_Plainkey(key))] = self.DBval_Plainval(value)
         if to_print and i%10==0: print(f'cached {self.name} row {i} of {self.Count()} or {round(100*(i/self.Count()), 1)}%.')
      print('done adding all rows to cache for table', self.name)

def DB_activate(db_dir): DB._SET_(Disk_DB(db_dir))

ONE_KEY = '*'

DB_TABLE_SPECS = [

#('_SANDBOX'                        , []                                ) ,
('_LangnameCode'                  , ) ,
('_CodeRectified'                 , ) ,
('_CodeLangs'                     , ) ,
('_LangAge'                       , ) ,
('_IncludeLangnames'              , ) ,
('_PIElangposet'                  , ) ,
('_GramtitleRedirect'             , ) ,
('_Gramtitle_XML'                 , ) ,
('_GRAM_Parsed'                   , ) ,
('_GRAM_AllMentioningGrams'       , ) ,
('_WORD_OwnFuturewardGramlinks'   , ) ,
('_WORD_Direction_OwnRefGrams'    , ) ,
('_GRAM_Direction_GivenRefGrams'  , ) ,
('_GRAM_StrictPastwards'          , ) ,
('_GRAM_ImmediatePastwards'       , ) ,
('_GRAM_Equivalents'              , ) ,
('_GRAM_ImmediateFuturewards'     , ) ,
('_GRAM_StrictFuturewards'        , ) ,
('_GRAM_RealGivenWords'           , ) ,
('_GRAM_Direction_Coveringwords'  , ) ,
('_GRAM_Coglang_LangStrictFutures', ) ,
('_WORD_PastwardPoset'            , ) ,
('_WORD_AllPastmostWords'         , ) ,
('_WORD_Lang_FuturewardPoset'     , ) ,
('_EnglishGramtext_Sortkey'       , ) ,
('_Tests'                         , ) ,

#('_CommonEnglishGrams'             , []                                 ) ,
#('_WORD_HTMLs'                     , ['WORD']                           ) ,
]




