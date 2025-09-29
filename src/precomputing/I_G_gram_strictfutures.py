from src.precomputing.coordinator import *

gram_strictfutures= {}
def REGISTER(gram): return gram_strictfutures.setdefault(gram, set())

def FUN(future_gram, strict_pastwards):
   REGISTER(future_gram)
   for past_gram in strict_pastwards: REGISTER(past_gram).add(future_gram)
   return []

to_do_1 = {'generator source':DB._GRAM_StrictPastwards, 'function':FUN, 'target tables':[], 'message':'get strict futures'}

to_do_2 = OBJECT_TABLE_TODO(gram_strictfutures, DB._GRAM_StrictFuturewards)

CALL([to_do_1, to_do_2])




