from src.classes import *
from src.printing.html import *
from src.printing.definitions import *

from src.printing.gram_elements import *
from src.printing.wiktionary import *
from src.printing.report import *

import ujson

def Word_CognatesDisplayContent(word):
   return {'HTML_CONTENT'       : Word_CognatesHTMLContent(word),
           'JAVASCRIPT_CONTENT' : Word_JScontent(word),
           'TITLE'              : Title(word)}

def Async_retriever():
   return '<div id="async-content">Computing futureward poset...</div>'

def Word_CognatesHTMLContent(word):
   (trunk_poset := word.PastwardWordposet())
   html = Aggregator()
   if trunk_poset is None:
      html << Paragraph('found nothing for ' + Gram_Element(word.gram, info={'kind':'generic'}) + ', word number: ' + str(word.num))
      if Log.directory == 'server':
         Log(word, 'unsuccessfully_computed')
      return Word_ReportHTMLContent(word, prefix=html())
   else:
      html << Starting_word(word)
      html << Text_Legendheader('Pastward trunk: ')
      html << Trunkposet_PastwardtrunkHTML(trunk_poset)
      html << Async_retriever()
      if Log.directory == 'server':
         Log(word, 'successfully_computed')
      return html()

def Trunkposet_PastwardtrunkHTML(trunk_poset):
   return GramUlteriorsAlreadysDirection_Html(trunk_poset.domain[0], trunk_poset.immediate_ulteriors, set(), 'pastward', trunk_poset.includedWords, givenExclusions=trunk_poset.generally_excluded_domain_set())

def Title(starting_word):
   return ' '.join([starting_word.text, str(starting_word.num), DB._CodeLangs.OneValue().get(starting_word.lang, 'unknown_lang'), ])

def Starting_word(starting_word):
   html = Aggregator()
   html << Text_Legendheader('Starting gram: ')
   html << Paragraph(Gram_Element(starting_word.gram, info={'kind':'generic'}) + ', word number: ' + str(starting_word.num))
   html << Paragraph(Word_Wiktionary(starting_word))
   html << Word_FullDefinitionHTML(starting_word)
   return html()

def GramUlteriorsAlreadysDirection_Html(gram, immediate_ulteriors, alreadyIncluded, direction, includedWords, givenExclusions=set()):
   tree = GramUlteriors_Traversal(gram, immediate_ulteriors, alreadyIncluded)
   # this is  aa bbbug. we should show the lang for the first of each lang. see for example 
   #   .ink/weave;  ├PG *wabōną┬PWG *wabbjan:cause to weave;wrap,entangle ▲; *wabōn ▲; ráfa ▲
   #localhost   PG *waibijaną:wind (around),wrap;move around;turn;wave-PWG *waibijan:move around;turn;waver;go back and forth ▲; veifa:wave ▲
   def subtree_text(subtree):
      return G_semicolon_element.join(Gram_Element(child['gram'], info={'kind':'printing_tree','with_lang':i==0, 
               'already_included': child['info']['already included'], 
               'parent_gram': subtree.get('parent_gram', None), 'parent_direction':direction,
               'generally_excluded': child['gram'] in givenExclusions, 'included_words': includedWords[child['gram']]}) 
              for i,child in enumerate(subtree['node']))

   return TreeNodetext_HTML(tree, subtree_text)

InflectionLinks =  ['superlative of', 'genitive of', 'gerund of', 'definite singular of', 'obsolete form of', 'masculine plural past participle of', 'feminine singular past participle of', 'abbreviation of',  'female equivalent of', 'feminine plural past participle of', 'misspelling of', 'past participle of', 'adj form of', 'masculine plural of', 'feminine singular of', 'alternative spelling of', 'feminine plural of', 'alternative form of',  'participle of', 'present participle of', 'verb form of', 'plural of', 'inflection of',   'form of', 'pt-verb form of', 'ca-verb form of', 'es-verb form of', 'de-adj form of', 'el-form-of-nounadj', 'el-form-of-verb', 'en-past of', 'en-third-person singular of', 'en-superlative of', 'en-comparative of', 'en-archaic second-person singular of', 'en-irregular plural of', 'en-archaic third-person singular of', 'en-simple past of']

def GramParentgram_isOnlyInflection(gram, parent_gram):
   return all(WorddictParentgram_isInflection(word.Parsed(), parent_gram) for word in gram.AllRealGivenWords())

def GramParentgram_isInflection(gram, parent_gram):
   return any(WorddictParentgram_isInflection(worddict, parent_gram) for worddict in gram.Parsed().values())

def WorddictParentgram_isInflection(worddict, parent_gram):
   defs = Worddict_DefinitionsUnprocessed(worddict)
   for d in defs:
      for tok in d:
         if tok['kind'] == 'template':
            if tok['content']['kind'] in InflectionLinks:
               if 'gramtexts' in tok['content'] and parent_gram.text in tok['content']['gramtexts']:
                  return True
   return False

def ListKeyfun_Divide(xs, keyfun):
   results = []
   remaining = xs
   while len(remaining)> 0:
      key = keyfun(remaining[0])
      sublist, remaining = ListPredicate_Divide(remaining, lambda x: keyfun(x) == key)
      results.append(sublist)
   return results

def GramUlteriors_Traversal(root_gram, immediate_ulteriors, alreadyIncluded):
   info = {'already included': root_gram in alreadyIncluded, }
   alreadyIncluded.add(root_gram)
   if info['already included'] or root_gram not in immediate_ulteriors:
      children = []
   else:
      children_candidates = sorted(immediate_ulteriors[root_gram] & immediate_ulteriors.keys())
      # the reason we split, compute subtrees, and split again, is that we want the alreadyIncluded thing to go appropriately
      children_already_included, children_not_already_included = ListPredicate_Divide(children_candidates, lambda x: x in alreadyIncluded)  
      children_not_already_included.reverse()
      children_pre_chunked = [GramUlteriors_Traversal(child_gram, immediate_ulteriors, alreadyIncluded) 
                  for child_gram in children_already_included + children_not_already_included]
      initial_alreadys, remaining_children = ListPredicate_ChompUntil(children_pre_chunked, lambda tree: not tree['node'][0]['info']['already included'])
      children = [] if len(initial_alreadys) == 0 else [{'parent_gram':root_gram, 'node': [tree['node'][0] for tree in initial_alreadys], 'children': []}]

      for next_lang in ListKeyfun_Divide(remaining_children, lambda tree: tree['node'][0]['gram'].lang):
         for children_equivalent_list in ListKeyfun_Divide(next_lang, lambda tree: set(node_element['gram'] for child_tree in tree['children'] for node_element in child_tree['node'])):
            children.append({'parent_gram':root_gram, 'node': [node_element for equivalent_tree in children_equivalent_list 
                             for node_element in equivalent_tree['node']], 'children': children_equivalent_list[0]['children']}) #relies on ListKeyfun_Divide order-preserving

   return {'node': [{'gram':root_gram, 'info': info}], 'children': children}

def HTML_inlineFlex(html):
   return f'<div style="display:inline-flex;">{html}</div>'

def HTML_Div(html, attr_string=''):
   return f'<div {attr_string}>{html}</div>'

def TreeNodetext_HTML(tree, subtree_text, root=True, index=None, sibcount=None):
   # holy digusting batman
   acc = HTML_inlineFlex(('' if root else IndexSiblings_Prefix(index, sibcount))
                + subtree_text(tree) + HTML_Div('<br>'.join(
                TreeNodetext_HTML(ch, subtree_text, root=False, index=i, sibcount=len(tree['children'])) 
                for i,ch in enumerate(tree['children']))))
   return acc if not root else f'<div class="tree-container">{acc}</div>'

def IndexSiblings_Prefix(index, sibcount):
   if sibcount == 1         : prefix, subclass = '-'                  , 'tree-only-child'
   elif index == 0          : prefix, subclass = '┬' + VerticalLine() , 'tree-first-child'
   elif index == sibcount-1 : prefix, subclass = '└'                  , 'tree-last-child'
   else                     : prefix, subclass = '├' + VerticalLine() , 'tree-middle-child'
   return HTML_Div(prefix, attr_string=f'class="tree-prefix {subclass}"')

def VerticalLine():
   return '<div class="vertical-line"></div>'

