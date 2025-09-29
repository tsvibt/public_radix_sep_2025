from src.classes import *
from src.printing.html import *

def Worddict_Definitions(worddict):
   defs = []
   for section in Worddict_DefinitionsUnprocessed(worddict):
      text = Aggregator()
      for tok in section:
         if tok['kind'] == 'text':
            text << tok['content']
         elif tok['kind'] == 'template' and 'gramtexts' in tok['content']:
            if len(tok['content']['gramtexts'])>0:
               text << tok['content']['gramtexts'][-1]
         elif tok['kind'] == 'template' and tok['content']['kind'] in ['n-g', 'non-gloss definition']:
            text << tok['content']['text'].split('|')[-1].removesuffix('}}')
      for line in text().split('\n'):
         if line.startswith('#'):
            s_line = line.strip('# ')
            if not s_line.startswith('*') and not s_line.startswith(':') and not s_line.strip('# *:') == '':
               defs.append(s_line)
   return defs

def Worddict_DefinitionsUnprocessed(worddict):
   return [worddict[subheader] for subheader in worddict if subheader in ['Root', 'Numeral', 'Noun', 'Verb', 'Adjective', 'Adverb', 'Proper noun', 'Participle', 'Pronoun', 'Prefix', 'Preposition', 'Prepositional Phrase', 'Conjunction', 'Determiner', 'Contraction', 'Particle', ]]

def Word_Definitions(word):
   return Worddict_Definitions(word.Parsed())

def Word_FullDefinitionHTML(word):
   defs = [Text_BasicClean(defn) for defn in Word_Definitions(word)]
   if len(defs) < 4:
      return ''.join(Paragraph(f'{i+1}. {defn}') for i,defn in enumerate(defs))
   else:
      index = (len(defs)+1)//2
      return Tuples_HTMLtable(list(zip(defs[:index], defs[index:])))

def Text_ProcessSquareBrackets(x):
   ret = Aggregator()
   for i,dd in enumerate(x.split('[[')):
      if i>0:
         ddds=dd.split(']]')
         ddds[0] = SquareMap(ddds[0])
         ret << ''.join(ddds)
      else:
         ret << dd
   return ret().replace('[[', '').replace(']]', '')

def SquareMap(x):
   xs=x.split('|')
   match len(xs):
      case 1: return x
      case 2: return xs[1]
      case _: return ''

def Text_ExciseRefs(text):
   text = excise_substrings(text, '<ref>', '</ref>')
   text = excise_substrings(text, '<ref', '/>') # self closing ref tags
   text = excise_substrings(text, '&lt;ref&gt;', '&lt;/ref&gt;')
   text = excise_substrings(text, '&lt;ref', '/&gt;')
   return text

def Text_BasicClean(text):
   return Text_ProcessSquareBrackets(Text_ExciseRefs(text))

def ShortenDefs(defs, first_time=False):
   if first_time:
      defs = [Text_BasicClean(x) for x in defs]
#      defs = [Text_ExciseRefs(x) for x in defs]
#      defs = [Text_ProcessSquareBrackets(x) for x in defs]
#      defs = [x.replace('[[', '').replace(']]', '') for x in defs]
   defs = [x.replace(', ', ',') for x in defs]
   defs = [x.replace('  ', ' ') for x in defs]
   defs = [x.replace('; ', ';') for x in defs]
   defs = [x.replace(' or ', '/') for x in defs]
   defs = [x.replace(',or ', '/') for x in defs]
   defs = [x.strip(' .,:;!\'"/') for x in defs]
   defs = [x.replace('.;', ';') for x in defs]
   defs = [x.replace(';;', ';') for x in defs]
#   defs = [x.replace('<ref>', '') for x in defs]
#   defs = [x.replace('</ref>', '') for x in defs]
   defs = [x.replace('-->', '') for x in defs]
   defs = [x.replace('<!--', '') for x in defs]
   if first_time:
      #TODO do with regex for speed?
      for y in ['A', 'a', 'an', 'An', 'to', 'To', 'Be', 'be', 'I', 'the', 'The']:
         defs = [x.removeprefix(y + ' ') for x in defs]
         defs = [x.replace(';' + y + ' ', ';') for x in defs]
         defs = [x.replace(',' + y + ' ', ';') for x in defs]
   return defs


def Gram_Definitions(gram):
   return [defn for worddict in gram.Parsed().values() for defn in Worddict_Definitions(worddict)]

#TODO
def Gram_Definitionstring(gram, included_words=None):
#'' if not LangIsold(gram.lang) else 
   if len(included_words)==0:
      defs = Gram_Definitions(gram)
   else:
      defs = [defn for word in sorted(included_words) for defn in Word_Definitions(word)]
   defs = ShortenDefs(defs, first_time=True)
   defs = ShortenDefs(defs)
   defs = ShortenDefs(defs)
   defs = [x.strip() for x in defs if len(x.strip())>1]
   def_str = ';'.join(defs)
   return def_str[:(40 if LangIsold(gram.lang) else 25)]
   if LangIsold(gram.lang):
      return ';'.join(defs)[:40].strip()
   else:
      if len(defs)>0:
         return defs[0][:30].strip()
      else:
         return ''

#use _Langname_age?
def LangIsold(lang):
   return 'pro' in lang or (lang in DB._CodeLangs.OneValue() and ('Old' in DB._CodeLangs.OneValue()[lang] or 'Middle' in DB._CodeLangs.OneValue()[lang] or 'Proto' in DB._CodeLangs.OneValue()[lang] or 'Ancient' in DB._CodeLangs.OneValue()[lang]))

ShortenLangDict = {
   'Full Language Name': 'Shortened Language Name',
   'Middle High German': 'MHG',
   'Old High German': 'OHG',
   'Proto-Indo-European': 'PIE',
   'Proto-Germanic': 'PG',
   'Proto-West Germanic': 'PWG',
   'German': 'Ger',
   'English': 'En',
   'Middle English': 'ME',
   'Old English': 'OE',
   'Latin': 'La',
   'Spanish': 'Sp',
   'Ancient Greek': 'AGk',
   'Russian': 'Rus',
   }

def ShortenLang(lang):
   lang = ShortenLangDict[lang] if lang in ShortenLangDict else lang
   return lang.replace('Proto-', 'P-').replace('Old ', 'O.').replace('Middle ', 'M.').replace('Middle ', 'M.').replace('Creole', 'Cr.').replace('French', 'Fr')

