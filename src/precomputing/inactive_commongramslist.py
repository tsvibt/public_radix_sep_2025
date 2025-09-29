from src.precomputing.coordinator import *

G_English_grams_order_list = Read(RadixRootdir + 'resources/grams_by_frequency.txt').split('\n')

def get_commongrams():
   print('getting common grams....')
   grams = []
   for i, gramtext in enumerate(G_English_grams_order_list[:100000]):
      print('getting common grams... ', i, gramtext)
      gram = Gram(gramtext, 'en')
      gram_cap = Gram(gramtext.capitalize(), 'en')
      if Gram_Pastmosts(gram) !=None:
         grams.append(gram)
      elif Gram_Pastmosts(gram_cap) !=None:
         grams.append(gram_cap)

   print('done getting common grams.')

   print('excluding inflections...')
   included_commongrams_html = []
   for i, gram in enumerate(grams):
      if not any(GramParentgram_isOnlyInflection(gram, past_gram) for past_gram in GramDirection_Set(gram, 'pastward')):
         print('including only non-inflections... ',i, gram)
         included_commongrams_html.append(gram)

   print('done excluding inflections.')
   print(len(included_commongrams_html))
   return included_commongrams_html

to_do_1 = OBJECT_TABLE_TODO(get_commongrams(), DB._CommonEnglishGrams)


CALL([to_do_1, ])




