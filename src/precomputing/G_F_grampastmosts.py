'''
scalene src/precomputing/G_F_grampastmosts.py
python src/precomputing/G_F_grampastmosts.py
'''

from src.precomputing.multi_coordinator import *

RAM_grams_already_explored   = set()

def GramsDirection_UlteriorclosureGivens(uncompleted_grams, direction):
   Gram_Directionwardset = {}
   completed_grams = set()
   while len(uncompleted_grams) > 0:
      completed_grams.update(uncompleted_grams)
      #TODO : cache
      gram_directionset_pairs = DB._GRAM_Direction_GivenRefGrams.BatchGet([(item, direction) for item in uncompleted_grams])
      new_gram_sets = []
      for [gram, *xs], directionset in gram_directionset_pairs:
         new_gram_sets.append(Gram_Directionwardset.setdefault(gram, directionset or set()))
      uncompleted_grams = unionfold(new_gram_sets) - completed_grams

   return Gram_Directionwardset

def Gram_compute_Pastwardposet(gram):
   givens = GramsDirection_UlteriorclosureGivens({gram}, 'pastward')
   return Poset(givens, 'pastward', unsorted_domain=True)

# note: this does a weird thing with cycles between pastmosts. here we exclude them from each other's things, because we restrict to all_ulteriors; and even gram_exploring doesn't have to have everything in the poset be in its past! 

def FUN(gram_exploring, _dir, _givens):
   GLOBALCACHES.wipe_all()
   if gram_exploring in RAM_grams_already_explored: return []

   pastward_poset = Gram_compute_Pastwardposet(gram_exploring)
   for gram in set(pastward_poset.domain) - RAM_grams_already_explored:
      DB._GRAM_StrictPastwards.Row_QueuePair((gram, pastward_poset.strict_ulteriors[gram]))

#   RAM_gram_immediate_pastwards.update(pastward_poset.immediate_ulteriors)
   DB._GRAM_ImmediatePastwards.Dict_QueueDict(pastward_poset.immediate_ulteriors)
#   RAM_gram_equivalents        .update(pastward_poset.item_equivalents)
   DB._GRAM_Equivalents.Dict_QueueDict(pastward_poset.item_equivalents)
   RAM_grams_already_explored  .update(pastward_poset.domain)

#to_do_2 = OBJECT_TABLE_TODO(RAM_gram_immediate_pastwards , DB._GRAM_ImmediatePastwards)
#to_do_3 = OBJECT_TABLE_TODO(RAM_gram_equivalents         , DB._GRAM_Equivalents)



if __name__ == "__main__":

   to_do_1 = {'generator source':DB._GRAM_Direction_GivenRefGrams, 'function':FUN,
              'target tables':[DB._GRAM_StrictPastwards, DB._GRAM_ImmediatePastwards, DB._GRAM_Equivalents],} 

   CALL([to_do_1, ])



