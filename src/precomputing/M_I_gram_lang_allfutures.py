
from src.precomputing.multi_coordinator import *

def FUN(gram, strict_futureset):
   for coglang in G_Cached_Coglangs:
      DB._GRAM_Coglang_LangStrictFutures.Row_QueuePair((gram, coglang, {gram for gram in strict_futureset if gram.lang == coglang}))

if __name__ == "__main__":

   to_do_1 = {'generator source':DB._GRAM_StrictFuturewards, 'function':FUN, 
              'target tables':[DB._GRAM_Coglang_LangStrictFutures], 'batchsize': 3000}

   CALL([to_do_1,],) 



