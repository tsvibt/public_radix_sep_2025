'''
python src/site/server.py
https://en.wiktionary.org/wiki/Category:Proto-Indo-European_language
German
'''

from src.printing.html import *
from src.printing.gram_elements import *
from src.printing.cognates import *
from src.printing.PIE import *

# see js_appearance_defaults below for defulats
def settings_Colorpicker_background():
   return settings_Colorpicker('body-background')

def settings_Colorpicker_textcolor():
   return settings_Colorpicker('body-textcolor')

def settings_Colorpicker(setting):
   dataset = {'target_kind':'appearance-color', 'setting': setting}
   return f'<input type="color" class="colorPicker-appearance-{setting}" {Dataset_String(dataset)} value="#f2d7e6">{ResetButton(dataset)}'


def Lang_Coglangsetting(lang):
   return f'<span class="coglang-setter-wrapper">{Lang_dummy_element(lang)}{Lang_CoglangSetter(lang)}</span>'

def Lang_CoglangSetter(lang):
   dataset = {"target_kind":"lang-coglang", "lang":lang}
   return f'<input type="checkbox" id="coglangSetter-{lang}" {Dataset_String(dataset)}>'

def CoglangsPanel():
   return ' '.join(Lang_Coglangsetting(lang) for lang in sorted(G_Cached_Coglangs)) 

def AllCoglangsReset():
   dataset = {'target_kind':'lang-allcoglangs', } 
   return 'Reset all cognate languages to the default: ' + ResetButton(dataset)

def settings_Colorpicker_DEFAULT():
   return Lang_ColorSettings('DEFAULT')

def settings_Colorpicker_tree():
   tree = LangUlteriors_PlaceholderGramTraversal('ine-pro', PIE_langcode_poset_restricted.immediate_ulteriors)
   def subtree_text(subtree):
      return Lang_ColorSettings(subtree['node'])
   picker_tree = TreeNodetext_HTML(tree, subtree_text)
   return picker_tree

def ClearSettingsButton():
   return '<button class"clear-settings-button">clear all settings</button>'

def Lang_ColorSettings(lang):
   return f'<span class="color-picker-wrapper">{Lang_dummy_element(lang)}{Lang_ColorPicker(lang)}</span>'

def Lang_ColorPicker(lang):
   dataset = {'target_kind':'lang-color', 'lang':lang}
   return f'<input type="color" class="colorPicker-{lang}" {Dataset_String(dataset)} value="#f2d7e6">{ResetButton(dataset)}'

G_reset_symbol = '↺'
def ResetButton(dataset):
   return f'<span class="reset-button-wrapper reset-button-wrapper-unmodified" {Dataset_String(dataset)}><button class="reset-button" {Dataset_String(dataset)} onmouseover="handleMouseover(event)" onmouseleave="this.style.backgroundColor=\'transparent\';"> {G_reset_symbol} </button></span>'

def Lang_dummy_element(lang):
   return Gram_Element(Gram(DB._CodeLangs.OneValue()[lang], lang), info={'kind':'settings', 'def_str':':'+lang})

def LangUlteriors_PlaceholderGramTraversal(root_lang, immediate_ulteriors):
   children = [LangUlteriors_PlaceholderGramTraversal(child_lang, immediate_ulteriors) for child_lang in sorted(immediate_ulteriors[root_lang])]
   return {'node': root_lang, 'children': children}

#https://en.wiktionary.org/wiki/Category:Proto-Indo-European_language
#ine white
#grc green
#latin blue
#french purple
#english deep red
#german light right
#proto german orange
#uncolored yello?
#
# hm. maybe have english be purple, germanic red, latin blue, greek purple, and slavic green?  what about orange?

Langcolors = {
#   'DEFAULT': (232, 205, 220),
#   'DEFAULT': (230,235,200),
#   'DEFAULT': (193,205,205),
   'DEFAULT': (183, 197, 215),
   'language-code': (255,66,222),

   'ine-pro': (196, 148, 254),

   'gem-pro': (180,100,0), 
   'gmw-pro': (190,90,0), 
   'goh': (200,80,0), 
   'gmh': (210,60,0), 
   #'gml': (220,40,0), 
   'de': (235,10,0),

   #'non': (210,210,23),
   'non': (245, 180, 180),
   'gmq-pro': (242,153,80),

   'ang': (190,120,0), 
   'enm': (200,165,0), 
   #'en': Gray(255), 
   #'en': (250, 150, 250),
   #'en': (255, 220, 220),
#   'en': (230,235,200),
   'en': (232, 205, 220),

   'grk-pro': (0,180,255), 
   'grc': (0,200,255), 

   'itc-pro': (110, 160, 40),
   'itc-ola': (110, 180, 40),
   'la': (120, 190, 120),
   'fro': (140, 210, 120),
   'frm': (150, 230, 160),
   'fr': (150, 250, 190),

   #'sa': (255, 215, 145),
   'sa': (250, 150, 250),
   }

def js_appearance_defaults():
   return Dict_JSstring({'body-background': str([24,23,22]),
                         # 47 47 44 ; 43 42 39
                         'body-textcolor': str(list(Gray(220))),
                         })

def js_langcolor_defaults():
   return Dict_JSstring({lang:list(color) for lang,color in Langcolors.items()})

def Dict_JSstring(d):
   return '{' + ', \n'.join(f"'{k}':{v}" for k,v in d.items()) + '}'


