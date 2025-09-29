'''
scalene src/precomputing/N_QGI_gram_coverings.py
'''

from src.precomputing.multi_coordinator import *

def GramsetsDirection_CoverWords(sources, targets, direction):
   return {source_word for source_gram in sources for source_word in source_gram.AllRealGivenWords()
         if not source_word.Direction_Gramrefs(direction).isdisjoint(targets)}

def FUN(gram, strict_pasts):
   equivalents = gram.Equivalents()
   if equivalents is None: print('NO EQUIVALENTS FOR', gram)
   # weird + relies on grams being deterministically sorted; but better than 'already_got' set 
   if gram != sorted(equivalents)[0]: return 

   GLOBALCACHES.wipe_except({'DB._GRAM_Equivalents_CACHE_Get'})

   stricts = {'pastward': strict_pasts, 'futureward': gram.Direction_Stricts('futureward')}
   for direction in G_Directions:
      coverings = GramsetsDirection_CoverWords(stricts[Direction_Reversed(direction)], equivalents|stricts[direction], direction)
      for equivalent in equivalents: DB._GRAM_Direction_Coveringwords.Row_QueuePair((equivalent, direction, coverings))

if __name__ == "__main__":

   to_do_1 = {'generator source':DB._GRAM_StrictPastwards, 'function':FUN, 'target tables':[DB._GRAM_Direction_Coveringwords], }

   CALL([to_do_1, ], )





