"""
python src/precomputing/E_C_parse_linksrefs.py
python src/tests.py fulltest
"""
from src.precomputing.multi_coordinator import *

def FUN(gram, parsed):
   for wordnum, worddict in parsed.items():
      DB._WORD_OwnFuturewardGramlinks.Row_QueuePair(((word := Word(gram, wordnum)), WordDict_Gramlinks(word, worddict)))

if __name__ == "__main__":

   to_do_1 = {'generator source':DB._GRAM_Parsed, 'function':FUN, 'target tables':[DB._WORD_OwnFuturewardGramlinks], }

   CALL([to_do_1, ])



