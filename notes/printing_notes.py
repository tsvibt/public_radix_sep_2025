
"""

  var elem = document.getElementById("element3070" );
  var popup = document.getElementById("popup3070" );
  popup.style.display;
popup.style.display = 'block';


  var thing = popup.parentNode.getBoundingClientRect().top;
    var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
    thing + scrollTop


  var popup_rect = popup.getBoundingClientRect();
  var parent_rect = popup.parentNode.getBoundingClientRect();
  popup.style.display = "block";
 popup.style.transform = "translateX(-" + (popup_rect.left + parent_rect.left) + "px)";
      console.log(id);
}
"""

240208    07:58:32    
def Element(tag, text, style = ''):
   return f'<{tag} style="{style}">{text}</{tag}>'
#   return f'<{tag} style="{style}">' + text + f'</{tag}>'
def Text_Legendheader(text):
   return Paragraph(Color(Legend_color, text), style="width: 100%; background-color: rgba"+str(Legend_color_background))
#   return Paragraph(' ')*3 + Paragraph(Color(Legend_color, text))



   result += Text_Legendheader('Pastward tree: ')
   #todo: highlight guys who aren't in the narrow thing. maybe try to use definitions from narrow....
   result+=Thingy(cognates['trunk'].domain[-1], cognates['trunk'], set(), set(), sense_decorations=sense_decorations)
#   tree = FuturesetTraversal(cognates[0].domain[-1], cognates[0], set(), set())
#   result += Paragraph(PrintTree(tree, sense_decorations=sense_decorations), style="white-space: pre; ") 


# make a separate function. have to pass stuff
   if restricted_cognates != None:
      result += Text_Legendheader('From narrow radix: ')
      result += Wordlists_Print(restricted_cognates, etymonline_wordtexts)
   wide_radix_text = Wordlists_Print(cognates, etymonline_wordtexts, excluded_wordtexts=restricted_radix_wordtexts)
   if wide_radix_text.strip() != '':
      result += Text_Legendheader('Additional words, from wide radix: ') + wide_radix_text
   return result


               # this gives the wrong color for the first word. should really be separting the Lang from the word. 
               acc_trunk += Outline(Graya(150), Word_ColoredElement(trunk_word)) + ': ' 
            if not got_first:
               acc_trunk += Outline(Graya(150), Word_ColoredElement(trunk_word)) + ': ' 
               got_first = True
            else:
               acc_trunk += '; ' 
#            outline_color = {(1,1): (50, 255, 80, 0), (0, 1): (50, 255, 80, 1), (1,0): (55, 120, 255, .7), (0,0): (255, 80, 50, .5)}
#            acc_trunk += Background(outline_color[(word.wordtext in other_radix, word.wordtext in etymonline_wordtexts)], Word_Element(word)) 
            acc_trunk += Color((155, 170, 255, .9) if word.wordtext in etymonline_wordtexts else (255, 140, 130, 1), Word_Element(word))


#            acc_trunk += Color(Overlap_color if word.wordtext in etymonline_wordtexts else Disoverlap_color, Word_Element(word))
      acc_radix += '' if acc_trunk == '' else Paragraph(acc_trunk)
   return acc_radix



   for word in reversed(cognates['trunk'].domain):
      acc+=WordPoset_Html(word, cognates['tree'], alreadyIncluded, exclusionSet, sense_decorations=sense_decorations, other_cognates=other_cognates)
#      tree = WordPoset_Traversal(word, tree_poset, alreadyIncluded, exclusionSet)
#      acc+=Paragraph(PrintTree(tree, sense_decorations=sense_decorations, other_cognates=other_cognates), style="white-space: pre; ") 
   return acc

   if type(tree['node']) == type([]):
      STUFF = '; '.join([Outline(colooor(child['node']), Info_Box(child['info'], Word_ColoredElement(child['node'], with_lang=i==0, sense_decorations=sense_decorations))) for i,child in enumerate(tree['node'])])
#      acc += Element('span', STUFF, style = 'overflow: auto; max-width: 100%;')
      acc += STUFF
 

240208    09:17:47    
"""

exec(open('src/word_printing.py').read())
PrintSummaries(b[0], sense_decorations=b[1])

"""

from bs4 import BeautifulSoup

### etymonline

GWordtext_EtymonlineCognateLists = {}
for cognate_list in ujson.loads(Read(RadixRootdir + 'resources/etymonline_cognate_lists.txt')):
   for cognate in cognate_list:
      if cognate not in GWordtext_EtymonlineCognateLists:
         GWordtext_EtymonlineCognateLists[cognate] = []
      if cognate_list not in GWordtext_EtymonlineCognateLists[cognate]:
         GWordtext_EtymonlineCognateLists[cognate].append(cognate_list)

### sorting 

G_English_words_order = {word:i for i,word in enumerate(Read(RadixRootdir + 'resources/words_by_frequency.txt').split('\n'))}
G_English_words_order_len = len(G_English_words_order)

def English_word_sort_key(word):
   wordtext = word if type(word) == str else word.wordtext
   if wordtext in G_English_words_order:
      return G_English_words_order[wordtext]
   else: 
      return G_English_words_order_len + 1 + len(wordtext)

def English_word_frequency_sort(words):
   return sorted(words, key=English_word_sort_key)

## ---------------- Printing --------------------

def Color(rgb, text):
   return f'''<span style="color: rgb{rgb}">{text}</span>'''

def Gray(x):
   return (x,x,x)

def Graya(x):
   return (x,x,x,x)


def Darken(rgb, factor):
   r,g,b = rgb
   return (int(r / factor), int(g / factor), int(b / factor))

def Element(tag, text, style = ''):
   return f'<{tag} style="{style}">{text}</{tag}>'

def Paragraph(text, style = ''):
   return Element('p', text, style)

Overlap_color = Gray(245)
Disoverlap_color = (200,165,0)
Legend_color = (130,225,255)
Legend_color_background = (210,70,240, .35)
already_included_mark = Color((230, 160, 50), ' ▲') 

def Text_Legendheader(text):
   return Paragraph(Color(Legend_color, text), style="width: 100%; background-color: rgba"+str(Legend_color_background))

G_orphan_elements = []
ELEMENT_ID = 0
#PrintSummaries(b[0], sense_decorations=b[1])
def PrintSummaries(cognates, sense_decorations=None):
   global ELEMENT_ID
   global G_orphan_elements
   global G_cognates_printing
   G_cognates_printing = cognates
   G_orphan_elements = []
   ELEMENT_ID = 0
   result = Legend()
   restricted_cognates = None if sense_decorations == None else {
      i:PosetDomain_Restricted(cognates[i], Dict_Nonempties(sense_decorations[i])) for i in ['trunk','tree']}
   result += Summaries(cognates, restricted_cognates)

   result += Text_Legendheader('Pastward tree: ')
   result+=WordPoset_Html(cognates['trunk'].domain[-1], cognates['trunk'], sense_decorations=sense_decorations)

   if restricted_cognates != None:
      result += Text_Legendheader('Narrow radix tree: ')
      result += PrintHtml(restricted_cognates, sense_decorations=sense_decorations)
   result += Text_Legendheader('Wide radix tree: ')
   result += PrintHtml(cognates,  sense_decorations=None, other_cognates=restricted_cognates)
   result += ''.join(G_orphan_elements)
   result = Read(RadixRootdir + 'src/display.html').replace('CONTENT_PLACEHOLDER', result)
   Write(result, RadixRootdir + 'aux/text.html')

def WordPoset_Html(word, poset, alreadyIncluded=set(), exclusionSet=set(), sense_decorations=None, other_cognates=None):
   return WordLefts_Html(word, poset.immediate_lefts, alreadyIncluded=alreadyIncluded, exclusionSet=alreadyIncluded, sense_decorations=sense_decorations, other_cognates=other_cognates)

def WordLefts_Html(word, immediate_lefts, alreadyIncluded=set(), exclusionSet=set(), sense_decorations=None, other_cognates=None):
   tree = WordLefts_Traversal(word, immediate_lefts, alreadyIncluded, exclusionSet)
   return Paragraph(PrintTree(tree, sense_decorations=sense_decorations, other_cognates=other_cognates), style="white-space: pre; ") 

def Legend():
   return Paragraph(Color(Legend_color, 'Legend:') + Color(Overlap_color, ' overlapping words;') + 
        Color(Disoverlap_color, ' non-overlapping words') + '; already included: ' + already_included_mark)

def Outline(rgba, text):
   return Element('span', text, 'position: relative; z-index: 9999; outline: 1px solid rgba' + str(rgba) + ';')

def Background(rgba, text):
   return Element('span', text, 'position: relative; z-index: 9999; background-color: rgba' + str(rgba) + ';')

def Summaries(cognates, restricted_cognates):
   radix_wordtexts = {word.wordtext for word in cognates['tree'].domain if word.lang == 'en'}
   restricted_radix_wordtexts = set() if restricted_cognates == None else {word.wordtext 
                           for word in restricted_cognates['tree'].domain if word.lang == 'en'}
   etymonline_wordtexts = set() 
   start_word = cognates['trunk'].domain[-1]
   result = ''

   if start_word.lang == 'en' and start_word.wordtext in GWordtext_EtymonlineCognateLists:
      for cognate_list in GWordtext_EtymonlineCognateLists[start_word.wordtext]:
         etymonline_wordtexts.update(cognate_list)

   result += Text_Legendheader('From etymonline: ') 
   result += Paragraph('; '.join([Outline((50, 255, 80, 0) if cognate in restricted_radix_wordtexts 
                  else ((50, 255, 80, 1) if cognate in radix_wordtexts else (255, 80, 50, 1)), cognate) 
                  for cognate in English_word_frequency_sort(etymonline_wordtexts)]))

   if restricted_cognates != None:
      result += Text_Legendheader('From narrow radix: ')
      result += Wordlists_Print(restricted_cognates, etymonline_wordtexts)
   wide_radix_text = Wordlists_Print(cognates, etymonline_wordtexts, excluded_wordtexts=restricted_radix_wordtexts)
   if wide_radix_text.strip() != '':
      result += Text_Legendheader('Additional words, from wide radix: ') + wide_radix_text
   return result

def Wordlists_Print(cognates, etymonline_wordtexts, excluded_wordtexts=set()):
   cognates
   acc_radix = ''
   already_included_radix_wordtexts = set(excluded_wordtexts)
   for trunk_word in reversed(cognates['trunk'].domain):
      acc_trunk = ''
      got_first = False
      for word in English_word_frequency_sort(filter(lambda word: word.lang == 'en', cognates['tree'].all_lefts[trunk_word])):
          if word.wordtext not in already_included_radix_wordtexts and not any([earlier_word.lang == 'en' for earlier_word in cognates['tree'].all_rights[word]]):
            already_included_radix_wordtexts.add(word.wordtext)
            if not got_first:
               acc_trunk += Outline(Graya(150), Word_ColoredElement(trunk_word)) + ': ' 
               got_first = True
            else:
               acc_trunk += '; ' 
            acc_trunk += Color((155, 170, 255, .9) if word.wordtext in etymonline_wordtexts else (255, 140, 130, 1), Word_Element(word))
      acc_radix += '' if acc_trunk == '' else Paragraph(acc_trunk)
   return acc_radix

Coglangs = ['la', 'grc', ]
#Coglangs = ['la', 'grc', 'es', 'fr']
Endlangs = ['en', 'de',]
Coglangs += Endlangs


def PrintHtml(cognates,  sense_decorations=None, other_cognates=None):

   alreadyIncluded = set()
   exclusionSet = Poset_Exclusionset(cognates['tree'])
   acc=''
   for word in reversed(cognates['trunk'].domain):
      acc+=WordPoset_Html(word, cognates['tree'], alreadyIncluded=alreadyIncluded, exclusionSet=exclusionSet, sense_decorations=sense_decorations, other_cognates=other_cognates)
   return acc

def Dict_Nonempties(key_values):
   return {key for key, values in key_values.items() if len(values)>0}


def Poset_Exclusionset(poset):
   print('computing exclusion set...')
   excluded = set()
   made_progress = True
   new_domain = poset.domain
   while made_progress:
      made_progress = False
      old_domain = new_domain
      new_domain = set()
      for word in old_domain:
         if word not in excluded: 
            is_empty_derivative = any([parent_word.lang == word.lang 
                         or WordParentword_isInflection(word, parent_word) 
                        for parent_word in poset.immediate_rights[word]])
            if (((word.lang not in Coglangs or is_empty_derivative)
                    and all([later_word in excluded for later_word in poset.all_lefts[word]]))
                or (word.lang in Endlangs and is_empty_derivative)
                or any([parent_word in excluded for parent_word in poset.immediate_rights[word]])):
               excluded.add(word)
               made_progress = True
            else:
               new_domain.add(word)
   print('done computing exclusion set')
   return excluded

def Chomp(xs, predicate):
   cont = True
   chomp = []
   while cont:
      if len(xs)>0 and predicate(xs[0]):
         chomp.append(xs.pop(0))
      else:
         cont = False
   return chomp, xs

def Split(xs, predicate):
   yes = [x for x in xs if predicate(x)]
   no = [x for x in xs if not predicate(x)]
   return yes, no

def WordLefts_Traversal(root_word, immediate_lefts, alreadyIncluded, exclusionSet, parent_word=None):
   info = {'already included': root_word in alreadyIncluded, 
           'excluded': root_word in exclusionSet, }
   # if delete this, can delet parentword:
#           'is inflection': parent_word != None and WordParentword_isInflection(root_word, parent_word)}
   alreadyIncluded.add(root_word)
   if info['already included'] or info['excluded']:
      children = []
   else:
      children_candidates = [child_word for child_word in sorted(immediate_lefts[root_word]) 
                             if not child_word in exclusionSet]
      children_already_included, children_not_already_included = Split(children_candidates, lambda x: x in alreadyIncluded)  

      children_not_already_included.sort()
      children_not_already_included.reverse()
      children_pre_chunked = [WordLefts_Traversal(child_word, immediate_lefts, alreadyIncluded, exclusionSet, parent_word=root_word)
                  for child_word in children_already_included + children_not_already_included]
      initial_alreadys, rest = Chomp(children_pre_chunked, lambda tree: tree['info']['already included'])
      children = [] if len(initial_alreadys) == 0 else [{'node': initial_alreadys, 'children': [], 'info': {}}]
      while len(rest)> 0:
         LANG = rest[0]['node'].lang # necessary for some reason
         next_lang, rest = Chomp(rest, lambda tree: tree['node'].lang == LANG)
         alreadys, not_alreadys= Split(next_lang, lambda tree: tree['info']['already included'])
         not_alreadys_live, not_alreadys_dead  = Split(not_alreadys, lambda tree: len(tree['children'])>0)
         children += ([] if len(not_alreadys_dead) == 0 else [{'node': not_alreadys_dead, 'children': [], 'info': {}}])  
         children += not_alreadys_live 
         children += ([] if len(alreadys) == 0 else [{'node': alreadys, 'children': [], 'info': {}}])

   return {'node': root_word, 'children': children, 'info': info}

Connector_color = Gray(200)
def PrintTree(tree, stack=[], first=True, other_cognates=None, sense_decorations=None):
   acc = ''
   if first:
      if len(stack) > 0:
         acc += Color(Connector_color, '┬' if stack[-1]['has_more'] else '-')
   else:
      acc += '<br>' + Color(Connector_color, StackPrefix(stack))

   def colooor(thing):
      return (255, 255, 255, 0) if other_cognates == None or thing in other_cognates['tree'].domain else (255,130,210,.7)

   if type(tree['node']) == type([]):
      STUFF = '; '.join([Outline(colooor(child['node']), Info_Box(child['info'], Word_ColoredElement(child['node'], with_lang=i==0, sense_decorations=sense_decorations))) for i,child in enumerate(tree['node'])])
      acc += STUFF
   else:
      text = Outline(colooor(tree['node']), Info_Box(tree['info'], Word_ColoredElement(tree['node'], sense_decorations=sense_decorations)))
      acc += text
      stack.append({'text': BeautifulSoup(text, 'html.parser').get_text(), 'has_more': True})
      for i,ch in enumerate(tree['children']):
         if i == len(tree['children'])-1:
            stack[-1]['has_more'] = False
         acc += PrintTree(ch, stack=stack, first=(i==0), other_cognates=other_cognates, sense_decorations=sense_decorations)
      stack.pop()
   return acc

def Info_Box(info, text):
   if info['already included']:
      text = text + already_included_mark 
   return text


def StackPrefix(stack):
   ret = ''.join([ len(x['text'])*' ' + ('│' if x['has_more'] else ' ')  for x in stack])
   if len(stack)>0:
      if stack[-1]['has_more']:
         ret=ret[:-1] + '├'
      else:
         ret=ret[:-1] + '└'
   return ret

InflectionLinks =  ['superlative of', 'genitive of', 'gerund of', 'definite singular of', 'obsolete form of', 'masculine plural past participle of', 'feminine singular past participle of', 'abbreviation of',  'female equivalent of', 'feminine plural past participle of', 'misspelling of', 'past participle of', 'adj form of', 'masculine plural of', 'feminine singular of', 'alternative spelling of', 'feminine plural of', 'alternative form of',  'participle of', 'present participle of', 'verb form of', 'plural of', 'inflection of',   'form of', 'pt-verb form of', 'ca-verb form of', 'es-verb form of', 'de-adj form of', 'el-form-of-nounadj', 'el-form-of-verb', 'en-past of', 'en-third-person singular of', 'en-superlative of', 'en-comparative of', 'en-archaic second-person singular of', 'en-irregular plural of', 'en-archaic third-person singular of', 'en-simple past of']

def WordParentword_isInflection(word, parent_word):
   defs = Word_DefinitionsUnprocessed(word)
   for d in defs:
      for tok in d:
         if tok['kind'] == 'reference':
            if tok['content']['kind'] in InflectionLinks:
               if 'wordtexts' in tok['content'] and parent_word.wordtext in tok['content']['wordtexts']:
                  return True
   return False
   

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
Langcolors = { 'ine-pro': Gray(210), 

            'gem-pro': (180,100,0), 
            'gmw-pro': (190,90,0), 
            'goh': (200,80,0), 
            'gmh': (210,60,0), 
            'gml': (220,40,0), 
            'de': (235,10,0),
            
            'ang': (190,120,0), 
            'enm': (200,165,0), 
            'en': Gray(255), 

            'grk-pro': (0,180,255), 
            'grc': (0,200,255), 

            'itc-pro': (110, 160, 40),
            'itc-ola': (110, 180, 40),
            'la': (120, 190, 120),
            'fro': (140, 210, 120),
            'frm': (150, 230, 160),
            'fr': (150, 250, 190),
            }

def LangCol(lang):
   if lang in Langcolors:
      return Langcolors[lang]
   else: 
      return Gray(170)

def Word_ColoredElement(word: Word, with_lang=True, sense_decorations=None):
   lang_html = '' if not with_lang else Color(Darken(LangCol(word.lang), 1.4), ShortenLang(Codelangs[word.lang]) + " ") 
   word_html = Color(LangCol(word.lang), Word_Element(word))
   def_str = Word_Definitionstring(word, sense_decorations=sense_decorations) if LangIsold(word.lang) else ''
   def_str = ':' + def_str if len(def_str)>0 else ''
   defn_html = Color(Darken(LangCol(word.lang), 1.3), def_str)
   return lang_html + word_html + defn_html

#information to put in a hover: language; parents (entire pastset?); children (which?); etymology section; defs
#one click makes modal
#double click and cmd click both made wikt in new tab
# also on hover, highlight other positiosn of the same word/ ????
# somehow denoete that there aer other postions or not? 

# should for already includd have them appear, but then cut off and just show button pointing up. or one line summary

# make hover give an outline . 
# if it is not a given sense, then don't make a wiktioanry link. 
#len(Word_AllRealGivenSenses(sense.word))

def Word_Element(word: Word):
   global ELEMENT_ID
   ELEMENT_ID += 1
   ID = str(ELEMENT_ID)
   popup_content = Word_Popupcontent(word)
   G_orphan_elements.append(f'<span id="popup{ID}" class="popup" style="display:none">{popup_content}</span>')
   return  f'<button onclick="openModal_or_site(\'{Word_URL(word)}\', {ID} )" onmouseover="showPopup({ID})" onmouseout="hidePopup({ID})" id=element{ID}>{word.wordtext}</button>' 

def ProcessSquareBrackets(x):
   ret=''
   for i,dd in enumerate(x.split('[[')):
      if i>0:
         ddds=dd.split(']]')
         ddds[0] = SquareMap(ddds[0])
         ret+=''.join(ddds)
      else:
         ret+=dd
   return ret

def SquareMap(x):
   xs=x.split('|')
   if len(xs)==1:
      return x
   if len(xs)==2:
      return xs[1]
   if len(xs)>2:
      return ''


def ShortenDefs(defs):
   defs = [excise_substrings(x, '<ref>', '</ref>') for x in defs]
   defs = [excise_substrings(x, '&lt;ref&gt;', '&lt;/ref&gt;') for x in defs]
   defs = [excise_substrings(x, '<ref', '/>') for x in defs]
   defs = [excise_substrings(x, '&lt;ref', '/&gt;') for x in defs]
   defs = [ProcessSquareBrackets(x) for x in defs]
   defs = [x.replace('[[', '').replace(']]', '') for x in defs]
   defs = [x.replace(', ', ',') for x in defs]
   defs = [x.replace('  ', ' ') for x in defs]
   defs = [x.replace('; ', ';') for x in defs]
   defs = [x.replace(' or ', '/') for x in defs]
   defs = [x.replace(',or ', '/') for x in defs]
   defs = [x.strip(' .,:;!\'"/') for x in defs]
   defs = [x.replace('.;', ';') for x in defs]
   defs = [x.replace(';;', ';') for x in defs]
   defs = [x.replace('<ref>', '') for x in defs]
   defs = [x.replace('</ref>', '') for x in defs]
   defs = [x.replace('-->', '') for x in defs]
   defs = [x.replace('<!--', '') for x in defs]
   for y in ['A', 'a', 'an', 'An', 'to', 'To', 'Be', 'be', 'I', 'the', 'The']:
      defs = [x.removeprefix(y + ' ') for x in defs]
      defs = [x.replace(';' + y + ' ', ';') for x in defs]
      defs = [x.replace(',' + y + ' ', ';') for x in defs]
   return defs


def Word_Definitions(word):
   return [defn for sensedict in Word_Dict(word).values() for defn in Sensedict_Definitions(sensedict)]

def Word_DefinitionsUnprocessed(word):
   return [defn for sensedict in Word_Dict(word).values() for defn in Sensedict_DefinitionsUnprocessed(sensedict)]

def Word_Definitionstring(word, sense_decorations=None):
   if sense_decorations==None:
      defs = Word_Definitions(word)
   else:
      defs = [defn for sense in sense_decorations['tree'][word] for defn in Sense_Definitions(sense)]
   defs = ShortenDefs(defs)
   defs = ShortenDefs(defs)
   defs = ShortenDefs(defs)
   defs = [x for x in defs if len(x)>1]
   if LangIsold(word.lang):
      return ';'.join(defs)[:40]
   else:
      if len(defs)>0:
         return defs[0][:30]
      else:
         return ''

def LangIsold(lang):
   return 'pro' in lang or 'Old' in Codelangs[lang] or 'Middle' in Codelangs[lang] or 'Proto' in Codelangs[lang]

ShortenLangDict = {
   'Middle High German': 'MHG',
   'Old High German': 'OHG',
   'Proto-Indo-European': 'PIE',
   'Proto-Germanic': 'PG',
   'Proto-West Germanic': 'PWG',
   'German': 'Ger',
   'English': 'En',
   'Middle English': 'ME',
   'Old English': 'OE',
   'French': 'Fr',
   'Old French': 'OFr',
   'Latin': 'La',
   'Spanish': 'Sp',
   'Ancient Greek': 'AGk',
   }

def ShortenLang(lang):
   lang = ShortenLangDict[lang] if lang in ShortenLangDict else lang
   return lang.replace('Proto-', 'P-').replace('Old ', 'O.')

def dictadd(d, k, v):
   if k not in d:
      d[k] = []
   d[k].append(v)

def Word_Popupcontent(word):
#   order = Order_Reversed(OrderDomain_Restricted(G_cognates_printing['tree'].all_rights, G_cognates_printing['tree'].all_rights[word]))
#   return WordLefts_Html(word, order)

   return 'popup thingyyy'



240208    10:48:35    
#def Chomp(xs, predicate):
#   cont = True
#   chomp = []
#   while cont:
#      if len(xs)>0 and predicate(xs[0]):
#         chomp.append(xs.pop(0))
#      else:
#         cont = False
#   return chomp, xs

240208    11:20:01    
#information to put in a hover: language; parents (entire pastset?); children (which?); etymology section; defs
#one click makes modal
#double click and cmd click both made wikt in new tab
# also on hover, highlight other positiosn of the same word/ ????
# somehow denoete that there aer other postions or not? 

# should for already includd have them appear, but then cut off and just show button pointing up. or one line summary

# make hover give an outline . 
# if it is not a given sense, then don't make a wiktioanry link. 
#len(Word_AllRealGivenSenses(sense.word))


240209    17:50:50    
"""
word=Word('value', 'en')
domain = G_cognates_printing['tree'].all_rights[word] | {word}
immediate_lefts =OrderDomain_Restricted(G_cognates_printing['tree'].immediate_rights, domain)
tree = WordLefts_Traversal(word, immediate_lefts, set(), set())

text = Paragraph(Tree_HTML(tree, sense_decorations=None, other_cognates=None), style="white-space: pre; ") 

def WordLefts_Html(word, immediate_lefts, alreadyIncluded=set(), exclusionSet=set(), sense_decorations=None, other_cognates=None):
   tree = WordLefts_Traversal(word, immediate_lefts, alreadyIncluded, exclusionSet)
   return Paragraph(Tree_HTML(tree, sense_decorations=sense_decorations, other_cognates=other_cognates), style="white-space: pre; ") 


"""


#   order = Order_Reversed(OrderDomain_Restricted(G_cognates_printing['tree'].all_rights, G_cognates_printing['tree'].all_rights[orphan['word']] | {orphan['word']}))

240213    21:15:04    


#TODO: simplify. don't need to do this. just have the nodes be always lists,  i think? and then theyre children may or not be empty as aproprait. 


"""

#TODO: simplify. don't need to do this. just have the nodes be always lists,  i think? and then theyre children may or not be empty as aproprait. 
   if type(tree['node']) == type([]):
      acc += '; '.join([node_sensedecorations_outlined_element(child, sense_decorations, with_lang=i==0) for i,child in enumerate(tree['node'])])
   else:
      text = node_sensedecorations_outlined_element(tree, sense_decorations)
      acc += text
      stack.append({'text': BeautifulSoup(text, 'html.parser').get_text(), 'has_more': True})
      for i,ch in enumerate(tree['children']):
         if i == len(tree['children'])-1:
            stack[-1]['has_more'] = False
         acc += Tree_HTML(ch, stack=stack, first=(i==0), other_cognates=other_cognates, sense_decorations=sense_decorations)
      stack.pop()
   return acc

"""


def WordLefts_Traversal(root_word, immediate_lefts, alreadyIncluded, exclusionSet):
   info = {'already included': root_word in alreadyIncluded, 
           'excluded': root_word in exclusionSet, }
#           'kind': 'normal'}
   alreadyIncluded.add(root_word)
   if info['already included'] or info['excluded']:
      children = []
#      info['kind'] = 'dead end'
   else:
      children_candidates = [child_word for child_word in sorted(immediate_lefts[root_word]) 
                             if not child_word in exclusionSet]
      children_already_included, children_not_already_included = ListPredicate_Split(children_candidates, lambda x: x in alreadyIncluded)  
      children_not_already_included.sort()
      children_not_already_included.reverse()
      children_pre_chunked = [WordLefts_Traversal(child_word, immediate_lefts, alreadyIncluded, exclusionSet)
                  for child_word in children_already_included + children_not_already_included]
      initial_alreadys, remaining_children = ListPredicate_ChompUntil(children_pre_chunked, lambda tree: not tree['node'][0]['info']['already included'])
      children = [] if len(initial_alreadys) == 0 else [{'node': [tree['node'][0] for tree in initial_alreadys], 'children': []}]
#      children = [] if len(initial_alreadys) == 0 else [{'node': initial_alreadys, 'children': [], 'info': {}}]
#      children = [] if len(initial_alreadys) == 0 else [{'node': [tree['node'][0] for tree in initial_alreadys], 'children': [], 'info': {}}]
      while len(remaining_children)> 0:
         lang_children = []
         LANG = remaining_children[0]['node'][0]['word'].lang # have to do outside of lambda?
#         LANG = rest[0]['node'].lang # have to do outside of lambda?
         next_lang, remaining_children = ListPredicate_ChompUntil(remaining_children, lambda tree: tree['node'][0]['word'].lang != LANG)
         alreadys, not_alreadys = ListPredicate_Split(next_lang, lambda tree: tree['node'][0]['info']['already included'])
         not_alreadys_live, not_alreadys_dead  = ListPredicate_Split(not_alreadys, lambda tree: len(tree['children'])>0)
         lang_children.extend([] if len(not_alreadys_dead) == 0 else [{'node': [tree['node'][0] for tree in not_alreadys_dead], 'children': []}])
#         lang_children.extend([] if len(not_alreadys_dead) == 0 else [{'node': not_alreadys_dead, 'children': [], 'info': {}}])
#         lang_children.extend([] if len(not_alreadys_dead) == 0 else [{'node': [tree['node'][0] for tree in not_alreadys_dead], 'children': [], 'info': {}}])
         lang_children.extend(not_alreadys_live)
         assert len(alreadys) == 0, print(root_word, alreadys)
#        lang_children += ([] if len(alreadys) == 0 else [{'node': alreadys, 'children': [], 'info': {}}])
         children.extend(lang_children)
#         children.extend(trees_absorb_diamond_waists(lang_children))

         # maybe right here, go through and absorb guys who only have a single child and the child is the same node as another previous guy....
         # actually.... maybe absorb guys who simply have the same descendants...? to prevent this : 
#           ├ME thinken:think,ponder;deduce,figure out;grasp,und-OE þencan:think ▲; þencean:þencan ▲
#        ├ME thenken:thinken-OE þencan:think ▲; þencean:þencan ▲
#        ├ME thenchen-OE þencan:think ▲; þencean:þencan ▲
   return {'node': [{'word':root_word, 'info': info}], 'children': children}
#   return {'node': root_word, 'children': children, 'info': info}
#hm... this understanding of diamonds may not be enough. eg enm 'valew'. could try to go by is it claimed to be "alternative" and also is consistent with that in the tree? or trust the claim?


'''
def tree_child_nodes_flat(node):
   children = {}
   for child_tree in node['children']:
      child = child_tree['node']
      if type(child) == list:
         children.update(child)
      else:
         children.update(child)
   return children

def trees_absorb_diamond_waists(trees):
   new_trees = []
   for tree in trees:
      if TODO
      #TODO
      if the set is equal to the sets from previious guys. don't add, but put the node into the previous guy. 
'''


240214    03:29:34    
         # maybe right here, go through and absorb guys who only have a single child and the child is the same node as another previous guy....
         # actually.... maybe absorb guys who simply have the same descendants...? to prevent this : 
#           ├ME thinken:think,ponder;deduce,figure out;grasp,und-OE þencan:think ▲; þencean:þencan ▲
#        ├ME thenken:thinken-OE þencan:think ▲; þencean:þencan ▲
#        ├ME thenchen-OE þencan:think ▲; þencean:þencan ▲


#hm... this understanding of diamonds may not be enough. eg enm 'valew'. could try to go by is it claimed to be "alternative" and also is consistent with that in the tree? or trust the claim?

'''
def tree_child_nodes_flat(node):
   children = {}
   for child_tree in node['children']:
      child = child_tree['node']
      if type(child) == list:
         children.update(child)
      else:
         children.update(child)
   return children

def trees_absorb_diamond_waists(trees):
   new_trees = []
   for tree in trees:
      if TODO
      #TODO
      if the set is equal to the sets from previious guys. don't add, but put the node into the previous guy. 
'''
      '''
      should be sorted before being traverseed. has to be sorted, then traversed, then grouped by :
      alreadsy
      nonalreadys
         for each lang
            grouped by size of thing
      '''




def WordLefts_Traversal(root_word, immediate_lefts, alreadyIncluded, exclusionSet):
   info = {'already included': root_word in alreadyIncluded, 
           'excluded': root_word in exclusionSet, }
   alreadyIncluded.add(root_word)
   if info['already included'] or info['excluded']:
      children = []
   else:
      children_candidates = [child_word for child_word in sorted(immediate_lefts[root_word]) if not child_word in exclusionSet]
      children_already_included, children_not_already_included = ListPredicate_Divide(children_candidates, lambda x: x in alreadyIncluded)  
      children_not_already_included.sort()
      children_not_already_included.reverse()
      children_pre_chunked = [WordLefts_Traversal(child_word, immediate_lefts, alreadyIncluded, exclusionSet)
                  for child_word in children_already_included + children_not_already_included]
      initial_alreadys, remaining_children = ListPredicate_ChompUntil(children_pre_chunked, lambda tree: not tree['node'][0]['info']['already included'])
      children = [] if len(initial_alreadys) == 0 else [{'node': [tree['node'][0] for tree in initial_alreadys], 'children': []}]

#      lang_sublists = ListKeyfun_Divide(remaining_children, lambda tree: tree['node'][0]['word'].lang)
      for next_lang in ListKeyfun_Divide(remaining_children, lambda tree: tree['node'][0]['word'].lang):

#      while len(remaining_children)> 0:
         lang_children = []
#         LANG = remaining_children[0]['node'][0]['word'].lang # have to do outside of lambda?
#         next_lang, remaining_children = ListPredicate_ChompUntil(remaining_children, lambda tree: tree['node'][0]['word'].lang != LANG)
         next_lang_alreadys, next_lang_not_alreadys = ListPredicate_Divide(next_lang, lambda tree: tree['node'][0]['info']['already included'])
         assert len(next_lang_alreadys) == 0, print(root_word, next_lang_alreadys)

#LangLessThan
         not_alreadys_live, not_alreadys_dead  = ListPredicate_Divide(next_lang_not_alreadys, lambda tree: len(tree['children'])>0)
         lang_children.extend([] if len(not_alreadys_dead) == 0 else [{'node': [tree['node'][0] for tree in not_alreadys_dead], 'children': []}])
         lang_children.extend(not_alreadys_live)

         children.extend(lang_children)

   return {'node': [{'word':root_word, 'info': info}], 'children': children}


