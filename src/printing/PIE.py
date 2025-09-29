
from src.languagecodes import * 


def Langposet_FullExclusionset(poset):
   excluded = set()
   for lang in poset.domain:
      if lang not in excluded:
         for future_lang in poset.strict_ulteriors[lang]:
            if DB._CodeLangs.OneValue()[lang] == DB._CodeLangs.OneValue().get(future_lang, DB._CodeLangs.OneValue()[lang]):
               excluded.add(future_lang)
   return excluded - {poset.domain[0]}

def make_restricted_PIE():
   full_to_include = set(DB._PIElangposet.OneValue().domain) - Langposet_FullExclusionset(DB._PIElangposet.OneValue())
   restricted_strict_ulteriors = ItemsetDomain_Restricted(DB._PIElangposet.OneValue().strict_ulteriors, full_to_include - {'inc-ash', 'inc-sap', 'inc-cen-pro'})
   def code_rectified(lang): return DB._LangnameCode.OneValue()[DB._CodeLangs.OneValue()[lang]]
   super_restricted = OrderFun_Mapped(restricted_strict_ulteriors, code_rectified)

   strict_priors = Order_Reversed(super_restricted)
   coglangs = {x for x in G_Cached_Coglangs}
   if 'en' in coglangs:
      coglangs.add('fr')
      coglangs.add('non')
   new_domain = unionfold({lang} | strict_priors[lang] for lang in coglangs if lang in strict_priors and lang in DB._CodeLangs.OneValue())
   really_restricted_strict_ulteriors = ItemsetDomain_Restricted(super_restricted, new_domain)
   return Poset(really_restricted_strict_ulteriors)

def OrderFun_Mapped(order, fun):
   mapped = {}
   for k,v in order.items():
      mapped.setdefault(fun(k), set()).update({fun(x) for x in v})
   return mapped

'''
!!!
!!!
only load this in printing--setings!!
!!!
'''


PIE_langcode_poset_restricted = make_restricted_PIE()

