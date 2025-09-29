
from src.precomputing.multi_coordinator import *

def FUN(word, gramlinkset):
   for source_index in [0,1]:
      DB._WORD_Direction_OwnRefGrams.Row_QueuePair((word, ['futureward', 'pastward'][source_index], 
                              {link[1-source_index] for link in gramlinkset if link[source_index] == word.gram}))


if __name__ == "__main__":

   to_do_1 = {'generator source':DB._WORD_OwnFuturewardGramlinks, 'function':FUN, 
              'target tables':[DB._WORD_Direction_OwnRefGrams], }

   CALL([to_do_1, ])



