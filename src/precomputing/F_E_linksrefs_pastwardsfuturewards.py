
from src.precomputing.coordinator import *

LINKS = {}
def REGISTER_LINKS(gram): return LINKS.setdefault(gram, {'pastward':set(), 'futureward':set()})

def Register_FutureLink(link):
   from_gram, to_gram = link
   REGISTER_LINKS(from_gram)['futureward'] . add(to_gram)
   REGISTER_LINKS(to_gram)['pastward']     . add(from_gram)

def FUN(word, future_gramlinks):
   REGISTER_LINKS(word.gram) # in theory, a gram could have an entry that never links and is never linked to
   [Register_FutureLink(link) for link in future_gramlinks]
   return []

def FUN2(gram, direction_grams):
   return [(gram, direction, grams) for direction, grams in direction_grams.items()]

to_do_1={'generator source':DB._WORD_OwnFuturewardGramlinks, 'function':FUN, 'target tables':[], 'message':'get refgrams'}
to_do_2={'generator source':LINKS, 'function':FUN2, 'target tables':[DB._GRAM_Direction_GivenRefGrams], 'message': 'writing '}

CALL([to_do_1, to_do_2])

