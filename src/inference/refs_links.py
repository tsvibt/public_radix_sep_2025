
from src.inference.classes import * 
from src.languagecodes import * 

import copy

def make_regex(code, name, arg, kind=None): globals()[name] = CodeNameRecognizer_Regex(code, name, arg, kind)

##### just by kind

#'PIE gram', 'root', 'derived',  'inherited', 'inflection of','borrowed','suffix', 'prefix', 'affix', 'compound', 'univerbation', 'blend', 'confix', 'de-adj form of', 'plural of', 'verb form of', 'participle of', 'back-formation'

make_regex('Primitive', 'Pr_general_pastward_ref', lambda content: content['kind'] in {'PIE gram', 'root', 'derived',  'inherited', 'inflection of','borrowed','suffix', 'prefix', 'affix', 'compound', 'univerbation', 'blend', 'confix', 'de-adj form of', 'plural of', 'verb form of', 'participle of', 'back-formation'}, kind='template')

def general_pastward_extractor(toks, word): #why? i forget
   return [] if 'affixes' in (ref := toks[-1]) and LangLang_isPastward(word.lang, ref['lang']) else [ref]

Inference_object('reference', Pr_general_pastward_ref, '', (general_pastward_extractor, 'pass_word'), 'pastward')
#Inference_object('reference', Pr_general_pastward_ref, '', -1, 'pastward')

make_regex('Primitive', 'Pr_general_futureward_ref', lambda content: content['kind'] in {'descendant'}, kind='template')
Inference_object('reference', Pr_general_futureward_ref, '', -1, 'futureward')

##### derived and descendants

#preventing {{l|ine-pro|*h₂éd|*h₂ed}}{{l|ine-pro||-bʰer-}} from linking forward to both. 

make_regex('Primitive' , 'Pr_link'                        , lambda content: content['kind'] == 'link'                                                 , kind='template')
make_regex('Primitive' , 'Pr_nonempty'                    , lambda content: content != ''                                                             , kind='text')
make_regex('Primitive' , 'Pr_notwith'                     , lambda content: not content.strip().endswith('with')                                      , kind='text')
make_regex('Primitive' , 'Pr_not_inparens'                , lambda content: not ('(' in content and ')' not in content and not content.endswith('(')) , kind='text')
make_regex('AND'       , 'Pr_not_empty_with_inparen'      , [Pr_nonempty, Pr_notwith, Pr_not_inparens])
make_regex('Pattern'   , 'P_nonempty_paren_link_nonempty' , [Pr_not_empty_with_inparen, Pr_link, Pr_nonempty])

Inference_object('reference', P_nonempty_paren_link_nonempty, 'Derived terms', 1, 'futureward')
Inference_object('reference', P_nonempty_paren_link_nonempty, 'Extensions'   , 1, 'futureward')
Inference_object('reference', P_nonempty_paren_link_nonempty, 'Descendants'  , 1, 'futureward')

make_regex('Primitive', 'Pr_mention', lambda content: content['kind'] == 'mention', kind='template')

make_regex('Primitive', 'Pr_asterisks', lambda content: '*' in content.split('\n')[-1] and content.split('\n')[-1].strip('* ') == '', kind='text')
make_regex('Pattern', 'P_asterisk_mention', [Pr_asterisks, Pr_mention])
Inference_object('reference', P_asterisk_mention, 'Derived terms', 1, 'futureward')

##### dash and 

make_regex('Primitive' , 'Pr_etymon'                  , lambda content: content['kind'] in ['inherited', 'derived', 'borrowed']                                , kind='template')
make_regex('Primitive' , 'Pr_dash'                    , lambda content: content['text'].split('|')[3].split('}}')[0].strip()=='-'                              , kind='template')
make_regex('AND'       , 'Pr_etymon_dash'             , [Pr_etymon, Pr_dash])
make_regex('Primitive' , 'Pr_and'                     , lambda content: content.strip() == 'and'                                                               , kind='text')
make_regex('Primitive' , 'Pr_somegrams'               , lambda content: 'gramtexts' in content and content['gramtexts'] != [] and content['kind'] != 'cognate' , kind='template')
make_regex('Pattern'   , 'P_etymondash_and_somegrams' , [ Pr_etymon_dash, Pr_and, Pr_somegrams])


def TokTok_Descendant(tok1, tok2):
   return LangLang_isFutureward(tok1['content']['lang'], tok2['content']['lang'])

def copy_gramtexts(tok1, tok2):
   result = copy.deepcopy(tok1)
   result['content'].update({'gramtexts':tok2['content']['gramtexts']})
   return result

dash_grams_REFS_EXTRACTOR = lambda toks: [copy_gramtexts(toks[0], toks[2])] if TokTok_Descendant(toks[0], toks[2]) else []
Inference_object('reference', P_etymondash_and_somegrams, 'Etymology', dash_grams_REFS_EXTRACTOR, 'pastward')

# list of pairs of refs, i guess
dash_grams_LINKS_EXTRACTOR = lambda toks: [(copy_gramtexts(toks[0], toks[2]), toks[2])] if TokTok_Descendant(toks[0], toks[2]) else []
Inference_object('link', P_etymondash_and_somegrams, 'Etymology', dash_grams_LINKS_EXTRACTOR, 'pastward')

# what do these look like when it's not a dash..? can there be both parallel and horizontal?


## COLUMNS
# basically always good? unsure. 
make_regex('Primitive', 'P_columns', lambda content: content['kind'] == 'columns', kind='template')
Inference_object('reference', P_columns, 'Derived terms', 0, 'futureward')


