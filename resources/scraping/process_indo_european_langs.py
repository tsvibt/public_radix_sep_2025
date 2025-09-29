"""
exec(open('resources/scraping/process_indo_european_langs.py').read())
line_profile.print_stats(output_unit=1e-03)
"""
exec(open('src/radix.py').read())

PIE_langcode_poset = Poset(ast.literal_eval(Read(RadixRootdir + 'resources/proto-indo-european-langs-tree.txt')))

def Langposet_FullExclusionset(poset):
   excluded = set()
   for lang in poset.domain:
      if lang not in excluded:
         for future_lang in poset.strict_ulteriors[lang]:
            if Codelangs[lang] == Codelangs.get(future_lang, Codelangs[lang]):
               excluded.add(future_lang)
   return excluded - {poset.domain[0]}

def make_restricted_PIE():
   full_to_include = set(PIE_langcode_poset.domain) - Langposet_FullExclusionset(PIE_langcode_poset)
   restricted_strict_ulteriors = ItemsetDomain_Restricted(PIE_langcode_poset.strict_ulteriors, full_to_include)
   super_restricted = OrderFun_Mapped(restricted_strict_ulteriors, code_rectified)

   strict_priors = Order_Reversed(super_restricted)
   coglangs = G_Cached_Coglangs
   if 'en' in coglangs:
      coglangs.add('fr')
      coglangs.add('non')
   new_domain = unionfold({lang} | strict_priors[lang] for lang in coglangs if lang in strict_priors and lang in Codelangs)
   really_restricted_strict_ulteriors = ItemsetDomain_Restricted(super_restricted, new_domain)
   return Poset(really_restricted_strict_ulteriors)

def code_rectified(lang):
   return Langcodes[Codelangs[lang]]

def OrderFun_Mapped(order, fun):
   mapped = {}
   for k,v in order.items():
      mapped.setdefault(fun(k), set()).update({fun(x) for x in v})
   return mapped

PIE_langcode_poset_restricted = make_restricted_PIE()

pickled = pickle.dumps(PIE_langcode_poset_restricted)

open(G_processed_PIE_tree_file,'wb').write(pickled)



