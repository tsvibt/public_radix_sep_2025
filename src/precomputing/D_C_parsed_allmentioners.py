"""
python src/precomputing/D_C_parsed_allmentioners.py
python src/tests.py fulltest
python src/tests.py onetest src/precomputing/D_C_parsed_allmentioners.py
python src/read_logs.py history 40k-initial _GRAM_AllMentioningGrams
python src/read_logs.py history mill-initial _GRAM_AllMentioningGrams
"""

from src.precomputing.multi_coordinator import *

def GramRef_RegisterMentioners(mentioner_gram, ref):
   if 'lang' in ref:
      for gramtext in ref['gramtexts'] + ref.get('affixes', []):
         DB._GRAM_AllMentioningGrams.KeyItem_QueueAppenddict(Gram(gramtext, ref['lang']), mentioner_gram)

def FUN(gram, parsed):
   [GramRef_RegisterMentioners(gram, token['content']) 
    for worddict in parsed.values() for tokens in worddict.values() for token in tokens if token['kind'] == 'template']

if __name__ == "__main__":

   to_do_1 = {'generator source':DB._GRAM_Parsed, 'function':FUN, 'target tables':[DB._GRAM_AllMentioningGrams],}

   CALL([to_do_1,])



