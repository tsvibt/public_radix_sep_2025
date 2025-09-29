"""
scalene src/precomputing/O_KN_word_pastwardwordposet.py
python src/precomputing/O_KN_word_pastwardwordposet.py
"""

from src.precomputing.multi_coordinator import *

all_pastmost_words = set()
already_pastmosted = set()

def FUN(gram_exploring, _):
   if gram_exploring in already_pastmosted: return 
   for gram in (pastward_poset := Gram_Pastwardposet(gram_exploring)):
      if gram not in already_pastmosted:
         already_pastmosted.add(gram)
         restricted_pastward_poset = pastward_poset if gram==gram_exploring else GramPoset_Ulteriorsubposet(gram, pastward_poset)
         for word in gram.GivensOrPlaceholder():
            pastward_wordposet = WordPoset_Wordposet(word, restricted_pastward_poset)
            DB._WORD_AllPastmostWords.Set_QueueSet(Wordposet_Ulteriormostwords(pastward_wordposet))
            DB._WORD_PastwardPoset.Row_QueuePair((word, pastward_wordposet))


if __name__ == "__main__":

   to_do_1 = {'generator source': DB._GRAM_ImmediateFuturewards, 'function':FUN,
              'target tables':[DB._WORD_PastwardPoset, DB._WORD_AllPastmostWords], }

   CALL([to_do_1, ],)




