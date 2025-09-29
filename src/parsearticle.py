"""
see notes in ../notes/scratch6.txt, "notes from parsearticle.py:"
"""

from src.utilities import * 
from src.classes import * 

from lupa import LuaRuntime
import re

lua = LuaRuntime(unpack_returned_tuples=True)
LUALang_Langinfo = lua.eval(Read(RadixRootdir + 'resources/wikt_languages_data_merged.lua'))()
LUAGramrawtextLang_Gramtext = lua.eval(Read(RadixRootdir + 'resources/mainfunction.lua'))

@GLOBALCACHES.CACHIFY
def GramrawtextLang_Gramtext_Redirect_corrected(gramrawtext, lang):
   try    : return Gramtitle_Gramtext(DB._GramtitleRedirect.OneValue()[Gram(gramrawtext, lang).Gramtitle()])
   except : return gramrawtext

@GLOBALCACHES.CACHIFY
def GramrawtextLang_Gramtext_LUA_corrected(gramrawtext, lang):
   try:
      thing = gramrawtext.strip().split('#Etymology')[0]
      return LUAGramrawtextLang_Gramtext(thing, lang, LUALang_Langinfo[lang])
   except:
      result = f'LUA gramtext failed on {gramrawtext} with lang {lang}'
      Log(result)
      print(result)
      return gramrawtext

@GLOBALCACHES.CACHIFY
def GramrawtextLang_Gramtext(gramrawtext, lang):
   return GramrawtextLang_Gramtext_Redirect_corrected(GramrawtextLang_Gramtext_LUA_corrected(gramrawtext, lang), lang)

def XML_Dict(xml_text):
   return Dict_AddReferences(Eqchunks_Dict(XML_Eqchunks(xml_text)))

def Dict_AddReferences(tree):
   for lang in tree:
      for word in tree[lang]:
         for subheader in tree[lang][word]:
            tree[lang][word][subheader] = TextReftokens(tree[lang][word][subheader])
   return tree

def XML_Eqchunks(xml_text):
   eqchunks = []
   kind = 'text'
   on_equals_block = False
   for eqchunk in re.split(r'(==+)', xml_text):
      if not on_equals_block:
         if kind == 'header':
            eqchunk = eqchunk.strip()
         eqchunks.append({'kind': kind, 'content': eqchunk})
      else:
         if kind != 'text':
            kind = 'text'
         else:
            kind = 'lang' if len(eqchunk) == 2 else 'header'

      on_equals_block = not on_equals_block
   eqchunks[-1]['content'] = eqchunks[-1]['content'].split('</text>')[0]
   return eqchunks

part_of_speech_headers =  ['Adjective', 'Adverb', 'Ambiposition', 'Article', 'Circumposition', 'Classifier', 'Conjunction', 'Contraction', 'Counter', 'Determiner', 'Ideophone', 'Interjection', 'Noun', 'Numeral', 'Participle', 'Particle', 'Postposition', 'Preposition', 'Pronoun', 'Proper noun', 'Verb']

def ListPredicate_Split(xs, predicate):
   firsts, remaining = ListPredicate_ChompUntil(xs, predicate)
   result = [firsts]
   while len(remaining)>0:
      first = remaining[0]
      nexts, remaining = ListPredicate_ChompUntil(remaining[1:], predicate)
      result.append([first] + nexts)
   return result

def Eqchunks_Dict(eqchunks):
   tree = {}
   isLang = lambda eqchunk: eqchunk['kind'] == 'lang'
   for i,lang_list in enumerate(ListPredicate_Split(eqchunks, isLang)):
      if i>0: # just discarding PRElang
         assert lang_list[0]['kind'] == 'lang'
         lang = lang_list[0]['content']
         if lang in tree:
            Log("Error: multiple entries for language" + lang + "found." + str(eqchunks[:10]))
         else:
            tree[lang] = Tokens_Langdict(lang_list[1:])
   return tree

# this is a slow way of doing this
def isInflectionText(token):
   return token['kind'] == 'text' and any("{{" + inflection_template + "|" in token['content'] 
                for inflection_template_list in pastward_inflection_kind_lists_common 
                for inflection_template in inflection_template_list)

def do_Tokens_MarkLookaheads(tokens):
   for i,token in enumerate(tokens):
      token['inflection next'] = i<len(tokens)-1 and isInflectionText(tokens[i+1]) 

def isHeader(token):
   return token['kind'] == 'header'

def isInflectionNext(token):
   return isHeader(token) and token['inflection next']

def isPartOfSpeech(token):
   return isHeader(token) and token['content'] in part_of_speech_headers

def isEtymology(token):
   return isHeader(token) and token['content'].startswith('Etymology')

def isRoot(token):
   return isHeader(token) and token['content'] in ['Root', 'Numeral']

def isWordStarter(token):
   return (isEtymology(token) or isRoot(token) or (isPartOfSpeech(token) and isInflectionNext(token)))

def Tokens_Langdict(tokens):
   do_Tokens_MarkLookaheads(tokens)
   token_lists = ListPredicate_Split(tokens, isWordStarter)
   [token.pop('inflection next') for token_list in token_lists for token in token_list]

   def to_be_absorbed(tokens1, tokens2):
      return len(tokens1)>0 and isEtymology(tokens1[0]) and not isEtymology(tokens2[0]) and not any(map(isPartOfSpeech, tokens1))

   acc = []
   skip_next = False
   for i,token_list in enumerate(token_lists):
      if skip_next:
         skip_next = False
      elif i<len(token_lists)-1 and to_be_absorbed(token_list, token_lists[i+1]):
            skip_next = True
            acc.append(token_list + token_lists[i+1])
      else:
         acc.append(token_list)

   return {word_num:Tokens_Worddict(token_list) for word_num, token_list in enumerate(acc)}

def Tokens_Worddict(tokens):
   tree = {}
   for i,token_list in enumerate(ListPredicate_Split(tokens, isHeader)):
      if i==0:
         tree['PREsubheader'] = '\n'.join([token['content'] for token in token_list])
      else:
         tree.setdefault(token_list[0]['content'], '')
         tree[token_list[0]['content']] += '\n'.join([token['content'] for token in token_list[1:]])
   return tree

columns_templates = {'col', 'col-auto', 'col-u', 'col1', 'col1-u', 'col2', 'col2-u', 'col3', 'col3-u', 'col4', 'col4-u', 'col5', 'col5-u', 'der2', 'der3', 'der4'}

def TextReftokens(text):
   tokens = []
   depth = 0
   token = ''
   for x in re.split('({{|}})', text):
      if x == '{{':
         if depth > 0:
            token += x
         depth += 1
      elif x == '}}':
         depth -=1
         if depth > 0:
            token += x
         elif depth == 0:
            if token.split('|')[0] in columns_templates:
               tokens.extend(TextReftokens('|'.join(token.split('|')[1:]))) 
            tokens.append({'kind': 'template', 'content': ReftextRefdict(token)})
            token = ''
         else:
            Log('Reached negative depth parsing: ' + text)
            depth = 0
      else:
         token += x
         if depth == 0:
            tokens.append({'kind': 'text', 'content': token})
            token = ''
   return tokens


def ReftextRefdict(ref_text):
   #   doesn't deal with sub sub refs...
   allargs = excise_substrings(ref_text, '{{', '}}').split('|')
   eqargs, args = ListPredicate_Divide(allargs, lambda x: '=' in x)
   d = Refargs_Refdict(args)
   d['text'] = '{{' + ref_text + '}}'

   if d['kind'] not in ['unrecognized', 'bad template']:
#      if 'affixes' in d: #INCLUDING AFFIXES
#         d['gramtexts'] += d['affixes']

      if 'lang' in d:
         d['lang'] = d['lang'].split(',')[0].split('&')[0].strip('\n ')
         d['lang'] = DB._CodeRectified.OneValue().get(d['lang'], d['lang'])
         if d['lang'] not in DB._CodeLangs.OneValue():
            Log("d['lang'] not in DB._CodeLangs.OneValue():")
            Log(d)
            d['kind'] = 'bad template'
         elif 'gramtexts' in d:
            d['gramtexts'] = [gram for gramtext in d['gramtexts'] for gram in ([gramtext] if '[[' not in gramtext else gramtext.split('/'))]
            d['gramtexts'] = [gram.strip(', []/') for gram in d['gramtexts']] # don't strip )- b/c proto stuff is like ..(n)- or w/e
            d['gramtexts'] = [gram for gram in d['gramtexts'] if gram.strip(', []/()-') != '']
            d['gramtexts'] = [GramrawtextLang_Gramtext(gram, d['lang']) for gram in d['gramtexts']]
            for eqarg in eqargs:
               if eqarg.startswith('id='):
                  d['id'] = eqarg.split('id=')[1]
   return d

def Refargs_Refdict(args):
   try    : return Refkind_ArgsDict.get(args[0], lambda args: {'kind': 'unrecognized'})(args) 
   except : return {'kind': 'bad template'}

Refkind_ArgsDict = {}

def KindlistsFun_register(kindlists, fun):
   for kindlist in kindlists:
      new_fun = KindFun_Fun(kindlist[0], fun)
      for kind in kindlist: Refkind_ArgsDict[kind] = new_fun

def KindFun_Fun(kind, fun): return (lambda args: dict(fun(args), kind=kind))

non_inflection_kind_lists_common = [ ['cognate', 'cog'], ['descendant', 'desc', 'desctree', 'descendants tree'], [ 'link', 'l',], [ 'mention', 'm',], ['back-formation', 'back-form', 'bf']]
nonetymological_kind_lists_common = [ ['superlative of'], ['comparative of'], ['romanization of'], ['ellipsis of'], ['attributive form of'], ['contraction of', 'contr of'], ['genitive of'], ['definite singular of'], ['abbreviation of', 'abbr of'],]
pastward_inflection_kind_lists_common = [['gerund of'], ['masculine plural past participle of'], ['feminine singular past participle of'],  ['female equivalent of'], ['feminine plural past participle of'], ['misspelling of', 'missp'], ['past participle of'], ['adj form of'], ['masculine plural of'], ['feminine singular of'],  ['feminine plural of'],  ['participle of'], ['present participle of'], ['verb form of'], ['plural of'], ['inflection of', 'infl of'],    ['diminutive of', 'dim of'], ['dative plural of'], ['initialism of', 'init of'], ['dative of'] ,  ['noun form of'],   ]
alternate_inflection_kind_lists_common = [ ['alternative spelling of', 'alt sp'], ['alternative form of', 'alt form'], ['alternative case form of', 'alt case', 'alt caps'], ['standard spelling of', 'stand sp'], ['nonstandard spelling of'],]
obsolete_inflection_kind_lists_common = [ ['obsolete form of', 'obs form'], ['obsolete spelling of','obs sp'], ['archaic form of'], ['archaic spelling of'], ['dated form of', 'dated form']]
all_common_template_forms = non_inflection_kind_lists_common + alternate_inflection_kind_lists_common + pastward_inflection_kind_lists_common + obsolete_inflection_kind_lists_common + nonetymological_kind_lists_common

main_etymon_kindlists = [ ['inherited', 'inh', 'inh+'], ['derived', 'der', 'der+', 'uder', 'der?', 'undefined derivation'], ['borrowed', 'bor', 'lbor', 'bor+'], [ 'calque', 'clq', 'cal',], ]
columns_like_kindlists = [['doublet'], ['compound', 'com', 'com+'], ['blend'], ['univerbation', 'univ'], ['columns'] + list(columns_templates)]
language_specific_kindlists = [['pt-verb form of', 'pt-verb-form-of'], ['ca-verb form of'], ['es-verb form of'], ['de-adj form of'], ['el-form-of-nounadj'], ['el-form-of-verb'], ['en-past of'], ['en-third-person singular of'], ['en-superlative of'], ['en-comparative of'], ['en-archaic second-person singular of'], ['en-irregular plural of'], ['en-archaic third-person singular of'], ['en-simple past of']]

KindlistsFun_register(language_specific_kindlists , lambda args: {'lang':args[0].split('-')[0] , 'gramtexts': [args[1]]})
KindlistsFun_register(all_common_template_forms  , lambda args: {'lang':args[1]    , 'gramtexts': [args[2]]})
KindlistsFun_register(main_etymon_kindlists      , lambda args: {'lang':args[2]    , 'gramtexts': [args[3]]})
KindlistsFun_register(columns_like_kindlists     , lambda args: {'lang':args[1]    , 'gramtexts': [x.split('&')[0] for x in args[2:]]})
KindlistsFun_register([['root']]                 , lambda args: {'lang':args[2]    , 'gramtexts': args[3:]})
KindlistsFun_register([['PIE word']]             , lambda args: {'lang':'ine-pro'  , 'gramtexts': ['*'+args[2]]})
KindlistsFun_register([['form of']]              , lambda args: {'lang':args[1]    , 'gramtexts': [args[3]]})
KindlistsFun_register([['suffix', 'suf']]        , lambda args: {'lang':args[1]    , 'gramtexts': [args[2]]          , 'affixes': ['-'+args[3]] })
KindlistsFun_register([['prefix', 'pre']]        , lambda args: {'lang':args[1]    , 'gramtexts': [args[3]]          , 'affixes': [args[2]+'-'] })

KindlistsFun_register([['affix'  , 'af']]  , lambda args: {'lang':args[1] , 'gramtexts': [x for x in args[2:] if '-' not in x] , 'affixes': [x for x in args[2:] if '-' in x]})
KindlistsFun_register([['confix' , 'con']] , lambda args: {'lang':args[1] , 'gramtexts': args[2:][1:-1]                        , 'affixes': [args[2:][0] + '-' , '-' + args[2:][-1]]})

KindlistsFun_register([['also']]         , lambda args: {'lang': 'unknown' , 'gramtexts': args[1:]})
KindlistsFun_register([['alter', 'alt']] , lambda args: {'lang': args[1]   , 'gramtexts': args[2:]})

KindlistsFun_register([['wordid', 'sid'], ['etymid']], lambda args: {'target': args[2]})

KindlistsFun_register([['gloss', 'gl'], ['glossary', 'lg']] , lambda args: {'display_text': args[1]})


