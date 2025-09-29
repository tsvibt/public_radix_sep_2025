from src.precomputing.multi_coordinator import *

def GramParsed_compute_AllRealGivenWords(gram, parsed):
   return {Word(gram, wordnum) for wordnum in parsed.keys()
           if wordnum != 0 or any(token['kind'] == 'template' for _,v in parsed[0].items() for token in v)}

def FUN(gram, parsed):
   DB._GRAM_RealGivenWords.Row_QueuePair((gram, GramParsed_compute_AllRealGivenWords(gram, parsed)))

if __name__ == "__main__":

   to_do_1 = {'generator source':DB._GRAM_Parsed, 'function':FUN, 'target tables':[DB._GRAM_RealGivenWords], }

   CALL([to_do_1, ])


