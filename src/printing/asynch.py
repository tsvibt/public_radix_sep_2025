
from src.shared_state import DB
from src.utilities import ID_maker
from src.ordering import *
from src.printing.cognates import *
from src.printing.language_specific import *
from src.printing.inspection_html import *

def Jsonlangs_langs(json_langs):
   return G_Cached_Coglangs & set(json_langs)

def Json_Word(json):
   return Word(Json_Gram(json), json['word'])

def Async_content(json_data):
   word = Json_Word(json_data['starting_word'])
   Coglangs = Jsonlangs_langs(json_data['Coglangs'])
   return WordCoglangs_AsyncHTMLContent(word, Coglangs)

def WordCoglangs_Cognates(word, Coglangs):
   return {'trunk': word.PastwardWordposet(), 'tree': WordCoglangs_Wordposet(word, Coglangs)}

def Wordposet_Gramsgenerallyexcluded(wordposet):
   included_ulteriormosts = set(Wordposet_Filteredulteriormostwords(wordposet))
   generally_excluded = set()
   for gram in reversed(wordposet.domain):
      if wordposet.immediate_ulteriors[gram] == set():
         if not any(word in included_ulteriormosts for word in wordposet.includedWords[gram]):
            generally_excluded.add(gram)
      elif all(ulterior in generally_excluded for ulterior in wordposet.immediate_ulteriors[gram]):
         generally_excluded.add(gram)
   return generally_excluded

Wordposet._latebound_Wordposet_Gramsgenerallyexcluded = Wordposet_Gramsgenerallyexcluded

def Wordposet_Filteredulteriormostwords(wordposet):
   Ensure_usually_excluded_loaded()
   ulteriormosts = Wordposet_Ulteriormostwords(wordposet)
   not_excluded = [x for x in ulteriormosts if x not in G_usually_excluded_pastmost_words]
   if len(not_excluded) in [0, len(ulteriormosts)] : return ulteriormosts
   else                                            : return not_excluded

G_usually_excluded_pastmost_words = set()
G_usually_excluded_pastmost_words_loaded = False
def Ensure_usually_excluded_loaded():
   global G_usually_excluded_pastmost_words_loaded
   if not G_usually_excluded_pastmost_words_loaded:
      G_usually_excluded_pastmost_words_loaded = True
      def pastmost_excluder_wordify(string):
         args = [x.strip() for x in string.split(',')]
         gramtext = args[0]
         lang = 'en' if len(args)<2 else args[1]
         wordnum = 1 if len(args)<3 else args[2]
         return Word(gramtext, lang, wordnum)

      pastmost_excluder_words = map(pastmost_excluder_wordify, filter(lambda x: x.strip() != '' and x.strip()[0]!='#', Read(RadixRootdir + '/src/pastmost_excluders.txt').split('\n')))
      global G_usually_excluded_pastmost_words 
      for word in pastmost_excluder_words:
         try:
            G_usually_excluded_pastmost_words.update(pastmost_word 
               for pastmost_word in Wordposet_Ulteriormostwords(word.PastwardWordposet()))
         except:
            print('failed to load excluder word', word)


def PastmostwordCoglangs_Futurewordposets(pastmost_word, Coglangs):
   return [DB._WORD_Lang_FuturewardPoset.Get(pastmost_word, lang) for lang in Coglangs]

def WordposetCoglangs_Exclusionset(poset, Coglangs):
   excluded = set()
   mprint(f'exclusion set from {"none" if len(poset.domain) == 0 else poset.domain[0]}...', end=' ')
   is_empty_derivative = lambda gram: gram in poset.derivatives
   for gram in reversed(poset.domain):
      if gram.lang in G_Endlangs and is_empty_derivative(gram):
         excluded.add(gram)
   for gram in reversed(poset.domain):
      if gram not in excluded:
         if ((gram.lang not in Coglangs or is_empty_derivative(gram))
              and all(later_gram in excluded for later_gram in poset.immediate_ulteriors[gram])):
            excluded.add(gram)
   mprint('done.', end=' ')
   return excluded


def WordposetCoglangs_Excludedposet(poset, Coglangs):
   return Wordposet((poset, set(poset.domain)-WordposetCoglangs_Exclusionset(poset, Coglangs)), kind='restriction')

def WordCoglangs_Wordposet(word, Coglangs):
   pastward_wordposet = word.PastwardWordposet()
   future_wordposets = [WordposetCoglangs_Excludedposet(wordposet, Coglangs) 
                   for pastmost_word in Wordposet_Filteredulteriormostwords(pastward_wordposet) 
                   for wordposet in PastmostwordCoglangs_Futurewordposets(pastmost_word, Coglangs)]
   return Wordposet(future_wordposets + [Wordposet(pastward_wordposet, kind='reverse')], kind='merge')

def WordCoglangs_AsyncHTMLContent(word, Coglangs, new_id_count=None):
   ID_maker.maybe_reset(new_id_count)
   try:
      cognates = WordCoglangs_Cognates(word, Coglangs)
      html = Aggregator()
      html << Summaries(cognates)
      html << Text_Legendheader('Futureward tree: ')
      html << FutureposetHTML(word.gram, cognates)
      return html()
   except:
      return '<div>Something went wrong trying to get summaries or futureward poset.</div>'

def FutureposetHTML(gram, cogs):
   alreadyIncluded=set() 
   return ''.join(GramUlteriorsAlreadysDirection_Html(
                     gram, cogs['tree'].immediate_ulteriors, alreadyIncluded, 'futureward', Cognates_mergedincludeds(cogs)) 
                  for gram in cogs['trunk'].non_generally_excluded_domain())

def Cognates_mergedincludeds(cognates):
   tree_includes = copy.deepcopy(cognates['tree'].includedWords)
   for gram, words in cognates['trunk'].includedWords.items():
      tree_includes.setdefault(gram, set()).update(words)
   return tree_includes

#def Gram_eytmoline
#TODO break this out:
def Summaries(cognates):
   restricted_radix_gramtexts = {gram.text for gram in cognates['tree'].immediate_ulteriors.keys() if gram.lang == 'en'}
   etymonline_gramtexts = set() 
   start_gram = cognates['trunk'].domain[0]
   if start_gram.lang == 'en' and start_gram.text in GGramtext_EtymonlineCognateLists:
      for cognate_list in GGramtext_EtymonlineCognateLists[start_gram.text]:
         etymonline_gramtexts.update(cognate_list)

   html = Aggregator()

   if len(etymonline_gramtexts)>0:
      html << Text_Legendheader('Cognates from etymonline: ') 
      html << Paragraph((G_semicolon_element + ' ').join([Gram_Element(Gram(cognate, 'en'), 
                                    info={'kind':'etymonline_gramlist', 'in_radix_grams': cognate in restricted_radix_gramtexts})
                                  for cognate in English_gram_frequency_sort(etymonline_gramtexts)]))

   html << Text_Legendheader('Cognates from radix: ')
   html << Gramlists_Print(etymonline_gramtexts, cognates)
   for lang in G_print_summary_langs:
      break ###################################### for now ###############
      if lang != 'en':
         html << Text_Legendheader('Grams, from ' + DB._CodeLangs.OneValue()[lang] + ': ') 
#         html << Gramlists_Print(some posets, cognates, lang=lang)
         html << "OMIT for space"
   return html()

def Gramlists_Print(etymonline_gramtexts, cognates, lang='en'):
   acc_radix = Aggregator()
   already_included_radix_gramtexts = set()
   for trunk_gram in cognates['trunk'].non_generally_excluded_domain():
      acc_trunk = Aggregator()
      got_first = False
      for gram in English_gram_frequency_sort(DB._GRAM_Coglang_LangStrictFutures.CACHE_Get(trunk_gram, lang) & cognates['tree'].immediate_ulteriors.keys()):
         if gram.text not in already_included_radix_gramtexts:
            already_included_radix_gramtexts.add(gram.text)
            if not got_first:
               acc_trunk << (Gram_Element(trunk_gram, info={'kind':'summary_gramlist_trunk'}) + ': ')
               got_first = True
            else:
               acc_trunk << (G_semicolon_element + ' ')
            acc_trunk << Gram_Element(gram, info={'kind':'summary_gramlist', 'in_etymonlines':gram.text in etymonline_gramtexts})
      if acc_trunk.has_any(): acc_radix << Paragraph(acc_trunk())
   return acc_radix()



