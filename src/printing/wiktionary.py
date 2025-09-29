

from src.printing.gram_elements import *

def Worddict_EtymologySection(worddict):
   for section_start in ['Etymology', 'Root', 'Numeral']:
      for key, tokens in worddict.items():
         if key.startswith(section_start):
            return (key, tokens)
   return (None, None)

def Word_Wiktionary(word):
   section_name, tokens = Worddict_EtymologySection(word.Parsed())
   if section_name is None: return ''
   return '<span class="wiktionary-symbol"></span> ' + Color((200, 250, 220), section_name) + ': ' + Tokens_HTML(tokens)

def Tokens_HTML(tokens):
   raw = ''.join(Token_HTML(token) for token in tokens)
   return Text_ExciseRefs(raw)

def Token_HTML(token):
   if token['kind'] == 'text':
      return token['content']
   elif token['kind'] == 'template':
      ref = token['content']
      if ref['kind'] not in ['unrecognized', 'bad template'] and 'lang' in ref and 'gramtexts' in ref and ref['gramtexts'] != []:
         return '; '.join(Gram_Element(Gram(gramtext, ref['lang']), info={'kind':'wiktionary_text','with_lang':i==0,}) for i,gramtext in enumerate(ref['gramtexts'])) + ('. ' if ref['kind'] in ['PIE gram', 'root'] else '')
      else:
         text = ref['text']
         if text.split('{{')[1].split('|')[0] in ['listen', 'audio']:
            return ''
         else:
            return text


