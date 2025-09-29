
from src.shared_state import DB
from src.db import *

import sqlite3
import brotli
import pickle 
import io

#TODO clean up. just use another cache?

# wut.
_G_Server_module_name = 'src.site.server'
_G_Server_Unpickle = (__name__ == _G_Server_module_name)
class Unpickler(pickle.Unpickler):
   def find_class(self, module, name):
      if _G_Server_Unpickle and module == "__main__":
         module = _G_Server_module_name
      return super().find_class(module, name)
def Unpickle(byte_string): return Unpickler(io.BytesIO(byte_string)).load()
def Pickle(obj)          : return pickle.dumps(obj)



GGramtext_EtymonlineCognateLists = {}
for cognate_list in Unpickle(Read(RadixRootdir + 'resources/etymonline_cognate_lists.txt', read_type='rb')):
   for cognate in cognate_list:
      if cognate not in GGramtext_EtymonlineCognateLists:
         GGramtext_EtymonlineCognateLists[cognate] = []
      if cognate_list not in GGramtext_EtymonlineCognateLists[cognate]:
         GGramtext_EtymonlineCognateLists[cognate].append(cognate_list)

### sorting 

def English_gram_sort_key(gram):
   gramtext = gram if type(gram) == str else gram.text
   return DB._EnglishGramtext_Sortkey.OneValue().get(gramtext, len(gramtext) + 1 + len(DB._EnglishGramtext_Sortkey.OneValue()))

def English_gram_frequency_sort(grams):
   return sorted(grams, key= lambda x: (English_gram_sort_key(x), x))


