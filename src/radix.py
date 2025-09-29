"""
scalene src/radix.py
python src/radix.py
python src/site/server.py
python src/tests.py test
python src/tests.py fulltest
"""

from src.shared_state import DB
from src.autoconfig import * 
from src.utilities import * 
from src.ordering import * 
from src.classes import * 
from src.db import * 
from src.languagecodes import * 
 
from src.inference.inference import * 
from src.traversing import * 
#from src.wiktionary_autoconfig import * 
from src.config import * 

#Wiktionary._SET_(WiktionaryContext(WiktionaryXMLfile))

def GramtextLangWordnum_Realword(gramtext, lang, maybe_word_num):
   print('gramtext:', gramtext)
   print('lang:', lang)
   print('maybe_word_num:', maybe_word_num)
   if lang == 'none_given':
      for maybe_lang in ['en', 'de'] + list(G_Cached_Coglangs):
         if Gram(gramtext, maybe_lang).Direction_Immediates('pastward') != None : lang = maybe_lang; break
      if lang == 'none_given': lang = 'none_found'
   gram = Gram(gramtext, lang)
   if maybe_word_num == 'none_given' : word_num = 1 if len(givens := gram.GivensOrPlaceholder())>1 else min(givens).num
   else                              : word_num = int(maybe_word_num)
   print(word := Word(gram, word_num))
   return word

if globals().get('G_Server_mode', False): Ensure_usually_excluded_loaded()



