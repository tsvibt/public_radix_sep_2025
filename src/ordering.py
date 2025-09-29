
from src.utilities import * 

import copy
from functools import reduce
import operator

G_poset_order_attributes_ulterior = {'strict_ulteriors', 'immediate_ulteriors',} 
G_poset_order_attributes_prior = {'immediate_priors',} 
G_poset_order_attributes = G_poset_order_attributes_ulterior | G_poset_order_attributes_prior
G_poset_set_attributes = G_poset_order_attributes | {'item_equivalents',}
G_poset_all_attributes = G_poset_set_attributes | {'domain', 'direction'} 
#{'direction', 'domain', 'item_equivalents', 'immediate_ulteriors', 'immediate_priors', 'strict_ulteriors'}
class Poset:
#   @profile
   def __init__(self, ARG, direction=None, manual=False, unsorted_domain=False):
      if manual:
         given_attributes = ARG
         for attribute in G_poset_all_attributes:
            setattr(self, attribute, given_attributes[attribute])
      else:
         Item_Givenulteriors = ARG
         self.direction = direction
         given_ulteriors, given_priors = Item_Givenulteriors, Order_Reversed(Item_Givenulteriors)
         assert given_ulteriors.keys() == given_priors.keys()
         all_ulteriors, self.item_equivalents = UlteriorsPriors_NonstrictTransitiveClosure_Equivalents(given_ulteriors, given_priors)
         self.strict_ulteriors = {item: nonstrict_ulteriors - self.item_equivalents[item] for item, nonstrict_ulteriors in all_ulteriors.items()}
#         self.strictself_ulteriors = {gram: {gram} | strict_ulteriors for gram, strict_ulteriors in self.strict_ulteriors.items()}
         self.immediate_ulteriors = old_GivensStrictsEquivalents_Immediates(given_ulteriors, self.strict_ulteriors, self.item_equivalents)
         self.immediate_priors = Order_Reversed(self.immediate_ulteriors)
         self.domain = set(self.immediate_ulteriors.keys()) if unsorted_domain else ImmediateulteriorsImmediatepriors_Sorted(self.immediate_ulteriors, self.immediate_priors)
         assert len(self.domain) == len(self.strict_ulteriors) == len(self.immediate_ulteriors) == len(self.immediate_priors) == len(all_ulteriors) 
   def strictself_ulteriors(self, gram): return self.strict_ulteriors[gram] | {gram} 

   def __eq__(self, other): 
      if other is None               : return False
      if not isinstance(other, Poset): raise Exception("why can't fruit be compared")
      return all(getattr(other, attribute) == value for attribute, value in vars(self).items())

   def __iter__(self): return iter(self.domain)
   def __repr__(self): return f"{', '.join(str(gram) for gram in self.domain)}]"

#domain, immediate ulteriors, includedWords, derivatives
class Wordposet:
   def __init__(self, ARG, kind='from_old'):
      match kind:
         case 'from_poset':
            poset, includedWords = ARG
            self.direction = poset.direction
            domain = Dict_Nonempties(includedWords)
            self.domain = [gram for gram in poset.domain if gram in domain]
            self.immediate_ulteriors = ItemsetDomain_Restricted(poset.immediate_ulteriors, domain)
            self.includedWords = includedWords
            self.derivatives = {gram for gram in self.domain if 
               any(parent_gram.lang == gram.lang for parent_gram in poset.immediate_priors[gram])}
         case 'restriction':
            wordposet, restriction_domain = ARG
            self.direction = wordposet.direction
            self.domain = [gram for gram in wordposet.domain if gram in restriction_domain]
            self.immediate_ulteriors = ItemsetDomain_Restricted(wordposet.immediate_ulteriors, restriction_domain)
            self.includedWords = ItemsetDomain_Keyfilter(wordposet.includedWords, self.domain) 
            self.derivatives = wordposet.derivatives & restriction_domain
         case 'merge':
            wordposets = ARG
            self.direction = wordposets[0].direction
            self.domain = []
            already_domained = set()
            for wordposet in wordposets:
               for gram in wordposet.domain:
                  if gram not in already_domained:
                     already_domained.add(gram)
                     self.domain.append(gram)
            self.immediate_ulteriors = ItemSets_Merged(wordposet.immediate_ulteriors for wordposet in wordposets)
            self.includedWords = ItemSets_Merged(wordposet.includedWords for wordposet in wordposets)
            self.derivatives = unionfold(wordposet.derivatives for wordposet in wordposets)
         case 'reverse':
            wordposet = ARG
            self.direction = Direction_Reversed(wordposet.direction)
            self.domain = reversed(wordposet.domain)
            self.immediate_ulteriors = Order_Reversed(wordposet.immediate_ulteriors)
            self.includedWords = wordposet.includedWords
            self.derivatives = set() # not sure about this
   def __eq__(self, other): 
      match other:
         case None       : return False
         case Wordposet(): return all(getattr(other, attribute) == value for attribute, value in vars(self).items())
         case _          : raise Exception("why can't fruit be compared")

   def __iter__(self): return iter(self.domain)
   def __repr__(self): return f"{', '.join(str(gram) for gram in self.domain)}]"

   def non_generally_excluded_domain(self):
      if not hasattr(self, '_cached_non_generally_excluded_domain'):
         self._cached_non_generally_excluded_domain = [x for x in self.domain if x not in self.generally_excluded_domain_set()]
      return self._cached_non_generally_excluded_domain
   def generally_excluded_domain_set(self):
      if not hasattr(self, '_cached_generally_excluded_domain_set'):
         self._cached_generally_excluded_domain_set = self._latebound_Wordposet_Gramsgenerallyexcluded()
      return self._cached_generally_excluded_domain_set

def UlteriorsK_Kcycles(Item_Ulteriors, k):
   for k_sequence in UlteriorsK_Ksequences(Item_Ulteriors, k):
      if k_sequence[0] in Item_Ulteriors[k_sequence[-1]]:
         yield k_sequence

def UlteriorsK_Ksequences(Item_Ulteriors, k):
   for x in Item_Ulteriors:
      for seq in UlteriorsItemK_Ksequences(Item_Ulteriors, x, k, set()):
         yield seq

def UlteriorsItemK_Ksequences(Item_Ulteriors, x, k, exclusion_set):
   if x not in exclusion_set:
      if k==1:
         yield [x]
      else:
         for y in Item_Ulteriors[x]:
            for seq in UlteriorsItemK_Ksequences(Item_Ulteriors, y, k-1, {x}|exclusion_set):
               yield [x] + seq

#@REPORT
def UlteriorsEquivalentsK_MarkKcycles(Item_Ulteriors, Item_Equivalents, k):
   for cycle in UlteriorsK_Kcycles(Item_Ulteriors, k):
      mprint(' and '.join(map(str, cycle)), 'forms a ' + str(k) + '-cycle')
      EQUIVALENTS = unionfold(Item_Equivalents[x] for x in cycle)
      for x in EQUIVALENTS:
         Item_Equivalents[x] = EQUIVALENTS

def ItemsetItemkeysItem_Shortunionfold(item_set, item_keys, item):
#   return item_set[item] if len(item_keys[item])==1 else unionfold(item_set[z] for z in item_keys[item])
   return ItemsetKeysItem_Shortunionfold(item_set, item_keys[item], item)

def ItemsetKeysItem_Shortunionfold(item_set, keys, item):
   return item_set[item] if len(keys)==1 else unionfold(item_set[k] for k in keys)

def ItemsetKeys_Shortunionfold(item_set, keys):
   return item_set[list(keys)[0]] if len(keys)==1 else unionfold(item_set[k] for k in keys)



#NONSTRICT
def UlteriorsPriors_NonstrictTransitiveClosure_Equivalents(Item_Givenulteriors, Item_Givenpriors):
   Item_Equivalents = {item:{item} for item in Item_Givenulteriors.keys()}
   cycle_bound = 1
   mprint("taking transitive closure")
   remaining_domain, upcoming_candidates = set(Item_Givenulteriors.keys()), set(Item_Givenulteriors.keys())
   Item_AllNonstrictUlteriors = {item:{item} for item in Item_Givenulteriors.keys()}
   while len(remaining_domain)>0:
      madeprogress = False
      current_candidates, upcoming_candidates = upcoming_candidates & remaining_domain, set()
      for x in current_candidates:
         equivalents_ulteriors = ItemsetItemkeysItem_Shortunionfold(Item_Givenulteriors, Item_Equivalents, x)
         if not any(y in remaining_domain and y not in Item_Equivalents[x] for y in equivalents_ulteriors): 
            remaining_domain.difference_update(Item_Equivalents[x])
            ALL_ULTERIORS = unionfold(Item_AllNonstrictUlteriors[y] 
                      for equivalent in Item_Equivalents[x] for y in ({equivalent}|Item_Givenulteriors[equivalent]))
            for equivalent in Item_Equivalents[x]:
               Item_AllNonstrictUlteriors[equivalent] = ALL_ULTERIORS
            upcoming_candidates.update(ItemsetItemkeysItem_Shortunionfold(Item_Givenpriors, Item_Equivalents, x))
            upcoming_candidates.difference_update(Item_Equivalents[x])
            madeprogress = True
      if not madeprogress:
         if cycle_bound>50:
            raise Exception('cycle bound exceeded 50')
         cycle_bound += 1
         UlteriorsEquivalentsK_MarkKcycles(Item_Givenulteriors, Item_Equivalents, cycle_bound)
         upcoming_candidates = remaining_domain
   mprint("done taking transitive closure")
   return Item_AllNonstrictUlteriors, Item_Equivalents

def newer_GivensStrictsEquivalents_Immediates(item_givens, item_stricts, item_equivalents):
   result = {}
   for item in item_givens.keys():
      given_neighborhood = ItemsetItemkeysItem_Shortunionfold(item_givens, item_equivalents, item)
      given_full_neighborhood = unionfold(item_equivalents[neighbor] for neighbor in given_neighborhood)
      candidates = given_full_neighborhood - item_equivalents[item]
      candidates_stricts = ItemsetKeys_Shortunionfold(item_stricts, candidates)

      result[item] = candidates - candidates_stricts 
   return result

def old_GivensStrictsEquivalents_Immediates(_givens, item_stricts, _equivs):
   return {item: ulteriors - unionfold(item_stricts[x] for x in ulteriors) for item, ulteriors in item_stricts.items()}


def SymmetricReflexiveTransitive(dom, rel):
   equivalents = {x:{x} for x in dom}
   for (x,y) in rel:
      s = equivalents[x] | equivalents[y]
      for z in s:
         equivalents[z] = s
   return equivalents

import heapq

class HeapSet:
   def __init__(self):
      self.heap = []
      self.membership_set = set()
   def push(self, value):
      if value not in self.membership_set:
         heapq.heappush(self.heap, value)
         self.membership_set.add(value)
   def pop(self):
      if self.heap:
         popped_value = heapq.heappop(self.heap)
         self.membership_set.remove(popped_value)
         return popped_value
      else:
         raise IndexError("pop from an empty heap")
   def contains(self, value):
      return value in self.membership_set
   def len(self):
      return len(self.membership_set)

# could write with FIX...
#the reason we're using a heapq is to order the domain by gram ordering. but this is unnecessary in many cases, and seems to be time costly. should probably do it later (perhaps in more restricted contexts, i.e with smaler domain...)
# could use equivalents; just print all equivalents immediately.
def ImmediateulteriorsImmediatepriors_Sorted(Item_Immediateulteriors, Item_Immediatepriors):
   sort = []
   candidates = HeapSet()
   [candidates.push(x) for x, x_priors in Item_Immediatepriors.items() if len(x_priors)==0]
   not_yet_sorted = Item_Immediatepriors.keys() - candidates.membership_set
   while len(not_yet_sorted) > 0 or candidates.len() > 0:
      x = candidates.pop()
      sort.append(x)
      for y in Item_Immediateulteriors[x]:
         if not any(z in not_yet_sorted or candidates.contains(z) for z in Item_Immediatepriors[y]):
            not_yet_sorted.discard(y)
            candidates.push(y)
   return sort

#https://codewiz.app/app/chat/python/eflHbV8iHnDQow6ZC6gX
def Order_Reversed(Item_Ulteriors):
   Item_Priors = {key:set() for key in Item_Ulteriors}
   for prior, ulteriors in Item_Ulteriors.items():
      for ulterior in ulteriors:
         Item_Priors[ulterior].add(prior)
   return Item_Priors

def itemnexts_histogram(item_nexts):
   histogram = {}
   for nexts in item_nexts.values():
      Histogram_add(histogram, len(nexts))
   return histogram

def ItemsetDomain_Restricted(Item_Set, domain):
   return {item: domain & Item_Set[item] for item in domain if item in Item_Set}

def ItemsetDomain_Keyfilter(Item_Set, domain):
   return {item: Item_Set[item] for item in domain if item in Item_Set}

def Direction_Reversed(direction):
   return {'futureward': 'pastward', 'pastward': 'futureward', None: None}[direction]

def Attribute_Reversed(attribute):
   return attribute.replace('prior', 'ulterior') if 'prior' in attribute else attribute.replace('ulterior', 'prior')

def PosetCloseddomain_Restricted(poset, domain):
   return PosetDomain_Restricted(poset, domain, domain_closed=True)

# not all calls respect equivalence classes! ie the domain might split one. 
def PosetDomain_Restricted(poset, domain, domain_closed=False):
   subdomainer = ItemsetDomain_Keyfilter if domain_closed else ItemsetDomain_Restricted
   domain = set(domain) & set(poset.domain)
   restricted_ulteriors = {attribute:subdomainer(getattr(poset, attribute), domain) for attribute in G_poset_order_attributes_ulterior}
   restricted_priors = {attribute:Order_Reversed(restricted_ulteriors[Attribute_Reversed(attribute)]) for attribute in G_poset_order_attributes_prior}
   direction = poset.direction 
#   wait why can't i just always do [x for x in poset.domain if x in domain] if domain_closed else?? lieke. we're not doing any reversing, that might be why; previously needed this. . 
   new_domain =  ImmediateulteriorsImmediatepriors_Sorted(restricted_ulteriors['immediate_ulteriors'], restricted_priors['immediate_priors'])
   item_equivalents = subdomainer(poset.item_equivalents, domain)
   if domain_closed:
      item_equivalents[new_domain[0]] = {new_domain[0]}

   all_attributes = Dicts_Union([restricted_ulteriors, restricted_priors, {'direction': direction, 'item_equivalents': item_equivalents, 'domain': new_domain}])
   return Poset(all_attributes, manual=True)

def Poset_Ulteriormosts(poset):
   return {gram for gram, ulteriors in poset.immediate_ulteriors.items() if len(ulteriors)==0}

G_Directions = ['pastward', 'futureward']

def Wordposet_Ulteriormostwords(wordposet):
   return [word for gram in Poset_Ulteriormosts(wordposet) for word in wordposet.includedWords[gram]]



