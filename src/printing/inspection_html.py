
from src.printing.html import *
from src.printing.wiktionary import *
from src.printing.inspection import *

G_Clusions = ['included', 'excluded']
def Json_ClusionWordnums(json):
   return {clusion:sorted(ujson.loads(json.get('words_' + clusion, '[]'))) for clusion in G_Clusions}

def Json_Gram(json, prefix=''):
   return Gram(json[prefix + 'gramtext'], json[prefix + 'lang'])

# external
def Json_Inspection(gram_json):
   info = {'gram'             : Json_Gram(gram_json),
           'clusion_wordnums' : Json_ClusionWordnums(gram_json)}
   if 'parent_gramtext' in gram_json:
      info['parent'] = {'gram'      : Json_Gram(gram_json, prefix='parent_'),
                        'direction' : gram_json['parent_direction']}
   return Info_Inspection(info)

def Info_Inspection(info, new_id_count=None):
   ID_maker.maybe_reset(new_id_count)

   gram = info['gram']

   result = Aggregator()
   result << Paragraph('gram: ' + Gram_Element(gram, info={"kind":"inspection"}))
   result << ClusionWordnums_WordsInspection(info['clusion_wordnums'])

   for word_num in sorted(info['clusion_wordnums']['included']):
      result << Paragraph(f'word {word_num}:' + ('' if word_num != -1 else ' no wiktionary article'))
      result << Paragraph(Word_Wiktionary(Word(gram, word_num)))
      result << Paragraph(Word_FullDefinitionHTML(Word(gram, word_num)))

   if (parent := info.get('parent')):
      for direction in G_Directions if (dir := parent['direction']) == 'both' else [dir]:
         result << GramGramDirection_InspectionHTML(gram, parent['gram'], direction)
   return result()

def ClusionWordnums_WordsInspection(clusion_wordnums):
   result = Aggregator() 
   for clusion in G_Clusions:
      if (words := clusion_wordnums[clusion]):
         result << Element('div', clusion + ' words: ' + ', '.join(str(x) for x in words), style='white-space: nowrap')
   return result()



