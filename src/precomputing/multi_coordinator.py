'''
python src/tests.py fulltest
'''
from src.radix import *
import time 
import os
import builtins
import multiprocessing
from functools import partial

Log.__init__('precompute')
mprint.printing_on = False

ABSTRACTED_HELPER = {} 
def CALL(to_dos, to_profile=(not globals().get('G_Server_mode', False))): 
   ABSTRACTED_HELPER['call'] = lambda: CALLED(to_dos)
   if not to_profile:
      ABSTRACTED_HELPER['call']()
   else:
      my_profile("ABSTRACTED_HELPER['call']()", log_file=Log.file(), log_string='targeting ' + ', '.join(table.name for to_do in to_dos for table in to_do['target tables']) + ', run on Wiktionary db: ' + str(Wiktionary.db_dir))

def CALLED(to_dos):
   for to_do in to_dos: TODO_EXECUTE(to_do)
   GLOBALCACHES.wipe_all()

def Iterator_Batched(iterator, batchsize = 30000):
   def generator():
      while (batch := list(islice(iterator, batchsize))): yield batch
   return generator()

def Todo_ArgsBatches(to_do):
   match (source := to_do['generator source']):
      case Disk_Table(): iterator = source.DBkeyIterator()
      case dict(): iterator = iter(source.items())
   batchsize = 100 # to_do.get('batchsize', 30000) .... or set default by type of xml, see notes
   return Iterator_Batched(iterator, batchsize)

#      case tuple(): return generator_source
#      case set()  : return (len(generator_source), map(lambda x: (x,), generator_source))
#      case dict() : return (len(generator_source), generator_source.items())
#      case _      : return (len(generator_source), generator_source)




def TODO_EXECUTE(to_do):
   [table.Drop() for table in to_do['target tables']]

   with multiprocessing.Pool() as pool:
      pool.map(partial(TodoArgsBatch_Do, to_do), Todo_ArgsBatches(to_do))
      for table in to_do['target tables']:
         if len(table.aux1().keys()) > 0:
            print(f'completing table {table.name}')
            pool.map(partial(Thingy, table), Iterator_Batched(iter(table.aux1().keys()), 10))

#            for db_key, index_cap in table.aux1().items():
#               table.index()[db_key] = table.Plainval_DBval(unionfold(table.DBval_Plainval(table.aux2()[DB_DELIMITER.join([db_key, str(index)])]) for index in range(index_cap)))

#            pool.map(partial(TodoArgsBatch_Do, to_do), Todo_ArgsBatches(to_do))

def TodoArgsBatch_Do(to_do, args_batch):
   print(args_batch[:3])
   for args in args_batch:
      match (source := to_do['generator source']):
         case Disk_Table() : to_do['function'](*(source.DBkey_Row(args)))
         case _            : to_do['function'](*args)
   
   [table.Execute_all_updates() for table in to_do['target tables']]



def Thingy(table, db_keys):
   updates = {db_key: table.Plainval_DBval(unionfold(table.DBval_Plainval(table.aux2()[DB_DELIMITER.join([db_key, str(index)])]) for index in range(table.aux1()[db_key]))) for db_key in db_keys}
   table.index().update(updates)


#   for db_key in db_keys:
##            for db_key, index_cap in table.aux1().items():
#      table.index()[db_key] = table.Plainval_DBval(unionfold(table.DBval_Plainval(table.aux2()[DB_DELIMITER.join([db_key, str(index)])]) for index in range(table.aux1()[db_key])))
#


