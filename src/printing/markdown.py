import markdown

from src.printing.html import *
from src.classes import *
from src.printing.gram_elements import *
from src.printing.settings import *

def Markdown_HTML(markdown_text):
   markdown_text = TextDividerFun_Replace(markdown_text, 'å', linkstring_link)
   markdown_text = TextDividerFun_Replace(markdown_text, '@@', replacestring_replacement)
   markdown_text = TextDividerFun_Replace(markdown_text, 'STL', stylestring_replace)
   markdown_text = TextDividerFun_Replace(markdown_text, 'BX', boxstring_boxed)
   return markdown.markdown(markdown_text, extensions=['toc', 'mdx_truly_sane_lists', 'footnotes', 'pymdownx.tilde', 'extra'], extension_configs={ 'mdx_truly_sane_lists': { 'nested_indent': 3, 'truly_sane': True, }})

def TextDividerFun_Replace(text, div, fun):
   xs = text.split(div)
   for i in range(1, len(xs), 2):
      xs[i] = fun(xs[i])
   return ''.join(xs)

def linkstring_link(x):
   x=x.strip()
   return f'[radix.ink/{x}](/{x})'


G_markdown_replacements = {}

def ensure_markdown_replacements():
   global G_markdown_replacements
   if G_markdown_replacements == {}:
      G_markdown_replacements = {
         'Wiktionary button'              : '<button class="wiktionary-button link-button"> </button>',
         'Etymonline button'              : '<button class="etymonline-button link-button"></button>',
         'Radix button'                   : '<button class="radix-button link-button"></button>',
         'Legend'                         : Legend(),
         'dummyLangElement'               : Lang_dummy_element('language-code'),
         'CoglangsPanel'                  : CoglangsPanel(),
         'AllCoglangsReset'               : AllCoglangsReset(),
         'dummyColorPicker'               : Lang_ColorPicker('language-code'),
         'settings_Colorpicker_background': settings_Colorpicker_background(),
         'settings_Colorpicker_textcolor' : settings_Colorpicker_textcolor(),
         'settings_Colorpicker_DEFAULT'   : settings_Colorpicker_DEFAULT(),
         'settings_Colorpicker_tree'      : settings_Colorpicker_tree(),
         'jump button'                    : f'<span class="jump-button button" >{already_included_mark}</span>',
      }

def replacestring_replacement(x):
   x=x.strip()
   ensure_markdown_replacements()
   if x.startswith('GRAM'):
      text, lang = x[len('GRAM'):].split(',')
      return Gram_Element(Gram(text.strip(), lang.strip()), info={'kind': 'page'})
   elif x.startswith('PASTWARD'):
      text, lang, num_str = x[len('PASTWARD'):].split(',')
      word = Word(text.strip(), lang.strip(), int(num_str.strip()))
      trunk_poset = word.PastwardWordposet()
      return Trunkposet_PastwardtrunkHTML(trunk_poset)
   else:
      return G_markdown_replacements[x]

def stylestring_replace(x):
   text = x.split(';')[-1]
   styles = Aggregator(['display:inline-block'], divider=';')
   for y in x.split(';')[:-1]:
      styles << ( ('' if ':' in y else 'color:') + y)
   return f'<div markdown="1" style="{styles()}">{text}</div>'

def boxstring_boxed(x):
   return f'<span class="boxed-text">{x.strip()}</span>'

# make into a table (swap)
def Legend():
   result = Text_Legendheader('Legend: ')
   gram1, gram2 = Gram('gram', 'en'), Gram('*wurdą','gem-pro')
   things = [('Cognate, per both etymonline and radix: '              , Gram_Element(gram1 , info={'kind':'etymonline_gramlist'    , 'in_radix_grams':True}))   , 
            ('Cognate per etymonline, but not per radix: '            , Gram_Element(gram1 , info={'kind':'etymonline_gramlist'    , 'in_radix_grams':False}))  , 
            ('Cognate per radix, but not per etymonline: '            , Gram_Element(gram1 , info={'kind':'summary_gramlist'       , 'in_etymonlines':False}))  , 
            ('Most recent common ancestor with starting gram: '       , Gram_Element(gram2 , info={'kind':'summary_gramlist_trunk' , }))                        , 
            ('Masked (futurewards excluded as irrelevant): '          , Gram_Element(gram1 , info={'kind':'printing_tree'          , 'generally_excluded':True  , 'already_included':False , 'with_lang':True})) , 
            ('Gram that has been already included in the same tree: ' , Gram_Element(gram1 , info={'kind':'printing_tree'          , 'generally_excluded':False , 'already_included':True  , 'with_lang':True})) , 
              ]
   return result + Paragraph('<br>'.join(x[0]+x[1] for x in things)) 

