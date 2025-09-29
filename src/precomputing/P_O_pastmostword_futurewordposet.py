'''
python src/precomputing/P_O_pastmostword_futurewordposet.py
scalene src/precomputing/P_O_pastmostword_futurewordposet.py
'''

from src.precomputing.multi_coordinator import *

def FUN(pastmost_gram, pastmost_words):
   gram_poset = Gram_Futureposet(pastmost_gram)
   for pastmost_word in pastmost_words:
      includedWords = GramposetGramwords_Includedwords(gram_poset, {pastmost_gram:{pastmost_word}})
      for lang in G_Cached_Coglangs:
         DB._WORD_Lang_FuturewardPoset.Row_QueuePair((pastmost_word, lang, PosetLangIncludedwords_Subwordposet(gram_poset, lang, includedWords)))

if __name__ == "__main__":

   print('processing pastmost words')
   pastmostgram_pastmostwords = {}
   for pastmost_word in DB._WORD_AllPastmostWords.SetIterator():
      print(pastmost_word)
      pastmostgram_pastmostwords.setdefault(pastmost_word.gram, set()).add(pastmost_word)
   print('done processing pastmost words')


   to_do_1 = {'generator source':pastmostgram_pastmostwords, 'function':FUN, 'target tables':[DB._WORD_Lang_FuturewardPoset], }# 'limit':30000}

   CALL([to_do_1, ], )



