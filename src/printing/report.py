from src.utilities import *
from src.ordering import *
from src.printing.html import *
from src.printing.gram_elements import *
def Word_ReportDisplayContent(word, prefix=''):
   return {'HTML_CONTENT'       : Word_ReportHTMLContent(word),
           'JAVASCRIPT_CONTENT' : Word_JScontent(word),
           'TITLE'              : Title(word)}

# make default opens be a set that's the shown-tables minus a couple
def Word_ReportHTMLContent(word, prefix=''):
   html = Aggregator([prefix])
   html << Paragraph(Gram_Element(word.gram, info={'kind':'generic'}) + ', word number: ' + str(word.num))
   defaultopens = [ '_WORD_OwnFuturewardGramlinks' ,       '_WORD_Direction_OwnRefGrams' ,  '_GRAM_Direction_GivenRefGrams' ,
                    '_GRAM_StrictPastwards' ,      '_GRAM_ImmediatePastwards' , '_GRAM_Equivalents' ,
                    '_GRAM_ImmediateFuturewards' , '_GRAM_RealGivenWords' ,      '_WORD_PastwardPoset']

   def ProcessDetails(res):
      if res is None: return None 
      elif type(res) in [set, list] and len(res)>0 and type(list(res)[0]) in [Gram, Word]:
         return ', '.join((Gram_Element if type(list(res)[0]) == Gram else Word_Element)
                 (item, info={'kind':'inspection', 'parent_gram': word.gram, 'parent_direction':'both'}) for item in res)
      else: return str(res)

   def maybe_sort(obj):
      return sorted(obj) if type(obj) in [set, list] else obj

   # DB._GRAM_StrictFuturewards, 
   for table in [DB._Gramtitle_XML, DB._GRAM_Parsed, DB._GRAM_AllMentioningGrams, DB._WORD_OwnFuturewardGramlinks, 
                 DB._WORD_Direction_OwnRefGrams, DB._GRAM_Direction_GivenRefGrams, DB._GRAM_StrictPastwards,
                 DB._GRAM_ImmediatePastwards, DB._GRAM_Equivalents, DB._GRAM_ImmediateFuturewards, 
                 DB._GRAM_RealGivenWords, DB._GRAM_Direction_Coveringwords, DB._WORD_PastwardPoset]:
      if table.name == '_Gramtitle_XML':
         html << FoldElement(str(table.Get(word.text)).replace('\n', '<br>'), table.name, table.name in defaultopens)
      else:
         arg1 = word if 'WORD' in table.name else word.gram
         if 'Direction' not in table.name: 
            res = table.Get(arg1) 
            if table.name == 'DB._WORD_PastwardPoset' and res != None:
               res = res.domain
            res = maybe_sort(res)
            html << FoldElement(str(res), table.name, table.name in defaultopens, details=ProcessDetails(res))
         else:
            for direction in G_Directions:
               res = maybe_sort(table.Get(arg1, direction))
               html << FoldElement(direction + ': ' + str(res), table.name, 
                                   table.name in defaultopens, details=ProcessDetails(res))
   return html()


def FoldElement(text, summary, default_open=False, details=None):
   full_preview = text.replace("<br>", " / ").replace("\n", " / ")
   preview = full_preview[:200]+ ("..." if len(full_preview)>200 else '')
   return f'<details {"open" if default_open else ""}><summary>{summary} <span style="color: gray">{preview}</span></summary>{Paragraph(text if details is None else details)}</details>'


