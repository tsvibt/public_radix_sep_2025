from src.precomputing.coordinator import *

gram_immediatefutures = {}
def REGISTER(gram): return gram_immediatefutures.setdefault(gram, set())

def FUN(future_gram, immediate_pastwards):
   REGISTER(future_gram)
   for past_gram in immediate_pastwards: REGISTER(past_gram).add(future_gram)
   return []

to_do_1={'generator source':DB._GRAM_ImmediatePastwards, 'function':FUN, 'target tables':[], 'message':'get immediate futures'}

to_do_2 = OBJECT_TABLE_TODO(gram_immediatefutures, DB._GRAM_ImmediateFuturewards)

CALL([to_do_1, to_do_2])




