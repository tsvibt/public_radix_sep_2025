from src.classes import *
from src.printing.html import *
from src.printing.definitions import *
import ujson

def Word_URL(word):
   return Gram_URL(word.gram)

def Gram_URL(gram : Gram):
   try:
      return "https://en.wiktionary.org/wiki/" + gram.Gramtitle() + '#' + DB._CodeLangs.OneValue()[gram.lang].replace(' ', '_')
   except:
      return "error from gram " + str(gram)

def GramInfo_RadixURLstem(gram, info):
   wordnums = Words_Wordnums(GramInfo_IncludedWords(gram, info))
   if len(wordnums)==0:
      wordnums = {x.num for x in gram.GivensOrPlaceholder()}
   wordnum = sorted(list(wordnums))[0]
   return f'/word/lang:{gram.lang}&wordnum:{wordnum}/{gram.text}'

def Words_Wordnums(words):
   return {word.num for word in words}

def GramInfo_IncludedWordnumsJSON(gram, info):
   return Wordnumset_JSON(Words_Wordnums(GramInfo_IncludedWords(gram, info)))

def GramInfo_IncludedWords(gram, info):
   return info.get('included_words', set())

def GramInfo_ExcludedWordnumsJSON(gram, info):
   return Wordnumset_JSON(Words_Wordnums(gram.GivensOrPlaceholder() - GramInfo_IncludedWords(gram, info)))

def Wordnumset_JSON(wordnumset):
   return ujson.dumps(list(wordnumset))

def Gram_EtymonlineURL(gram):
   return 'https://www.etymonline.com/word/' + gram.text

def Word_Element(word, info):
   return Color(Gray(150), Gram_Element(word.gram, info) + '_' + str(word.num))

def Resize(html):
   return f'<span class="downsize">{html}</span>'

def Dataset_String(dataset):
   return ' '.join(f'data-{key}={value}' for key,value in dataset.items())


G_multi_word_color = (255, 110,100)
G_two_word_element = Resize(Color(G_multi_word_color, 'ᐸ'))
G_poly_word_element = Resize(Color(G_multi_word_color, 'ᗕ'))
 
def Gram_Element(gram, info):
   HTMLid = info['kind'] + str(ID_maker.new())
   dataset = {'gramtext':gram.text,'lang':gram.lang,'words_included':GramInfo_IncludedWordnumsJSON(gram, info), 
        'words_excluded':GramInfo_ExcludedWordnumsJSON(gram, info), 'include_jump_down':True,
        'click_url':Gram_URL(gram), 'wiktionary_url':Gram_URL(gram), 'radix_url':GramInfo_RadixURLstem(gram, info)}
   if gram.lang == 'en':
      dataset['etymonline_url'] = Gram_EtymonlineURL(gram)

   if info.get('parent_gram', None) != None:
      dataset['parent_gramtext'] = info['parent_gram'].text
      dataset['parent_lang'] = info['parent_gram'].lang
      dataset['parent_direction'] = info['parent_direction']

   classes = Aggregator(['button', 'gram', 'lang-DEFAULT', f'lang-{gram.lang}', f'kind-{info["kind"]}'], divider=' ')

   include_lang_element = True
   include_definitions_element = False
   include_alreadyincluded_element = False

   pretext = ''

   match info['kind']: 
      case 'etymonline_gramlist':
         include_lang_element = False
         dataset['include_jump_down'] = info['in_radix_grams']
         classes << ('etymonline_and_radix' if info['in_radix_grams'] else 'etymonline_only')
         dataset['click_url'] = Gram_EtymonlineURL(gram)

      case 'summary_gramlist':
         include_lang_element = False
         if info['in_etymonlines']: classes << 'etymonline_and_radix'

      case 'summary_gramlist_trunk':
         include_definitions_element = True

      case 'printing_tree':
         dataset['include_jump_down'] = False
         include_lang_element = info['with_lang']
         include_definitions_element = True
         if info['generally_excluded']: classes << 'generally_excluded'
         include_alreadyincluded_element = info['already_included']
         word_count = len(GramInfo_IncludedWords(gram, info))
         pretext = ('' if word_count<2 else (G_two_word_element if word_count==2 else G_poly_word_element))

      case 'settings' | 'page':
         dataset['suppress_popups'] = True
         include_definitions_element = True

   content = Aggregator()
   content                                     << pretext
   if include_lang_element: content            << Lang_Element(gram.lang)
   content                                     << gram.text
   if include_definitions_element: content     << Gram_DefinitionsElement(gram, info, def_str=info.get('def_str', None))
   if include_alreadyincluded_element: content << GramParentid_AlreadyincludedElement(gram, HTMLid)

   return f'<span class="{classes()}" {Dataset_String(dataset)} onmouseover="handleMouseover(event)" onmouseout="hidePopup(event, {HTMLid})" id={HTMLid}>{content()}</span>'


# should differentiate trunk gram vs tree weord? 
def Gram_DefinitionsElement(gram, info, def_str=None):
   if def_str is None:
      def_str = Gram_Definitionstring(gram, info.get('included_words', set())) 
      def_str = ':' + def_str if len(def_str)>0 else ''
   return f'<span class="def_element">{def_str.strip()}</span>' 

def GramParentid_AlreadyincludedElement(gram, parent_id):
   dataset = {'gramtext':gram.text,'lang':gram.lang, 'parent_id': parent_id}
   return ' '+f'<span class="jump-button button" {Dataset_String(dataset)} onmouseover="handleMouseover(event)">{already_included_mark}</span>' 

def Lang_Element(lang):
   return 'BAD LANG' + lang if lang not in DB._CodeLangs.OneValue() else f'<span class="lang_element">{ShortenLang(DB._CodeLangs.OneValue()[lang])} </span>' 





