
from src.inference.refs_links import * 

def make_regex(code, name, arg, kind=None): globals()[name] = CodeNameRecognizer_Regex(code, name, arg, kind)

####### CONTINUATION MAIN

#fix this nonensewords :(
# include / exclude list, for purposes of testing? and go through them allllll...?
# we can split by spaces, and then go through grams and just delete any from a list... like delete "probably" and borrowing" and stuff, but if "from which" is there fuck that, and delet deverbal and nominal and adjective and....../????
# ", though"
#From {{der|cel-pro|ine-pro|*krek-|t=post}}, though this would yield an unexpected lengthened earlier form of {{m|cel-pro|*krēkʷ-}}.
#"earlier form of"
fromlist = {', from', ',  from', ', ultimately from',', possibly from',', itself from',', itself also from',', either from',', borrowed from',', in turn from',', inherited from',', probably ultimately from',', formed from',', developed figuratively from',', derived from',', probably from',', descended from',', originally from',', all from',', extracted from',', metathesis from',', contracted from',', presumably from',', a borrowing from',', itself derived from',', which ultimately comes (by dissimilation) from',', in part from',', itself a borrowing from',', traditionally derived from',', which is from',', itself probably from',', likely derived from',', formed either from',', both from',', perhaps from',', syncopated from',', in turn probably from',', which was formed from',', ultimately derived from',', itself borrowed from',', borrowing from',', further etymology uncertain but probably ultimately from',', itself a verbal noun from', ', an irregular formation from', ', partly from', ', adjective form from', ', which was from', ', a denominative verb from', ', coined by Plato from', ', from an unattested adjective derived from', ', which derives from', ', usually assumed to be from', ', denominative from', ', both ultimately from', ', deverbal from', ', maybe from', ', possibly (see above) from', ', [[metathesis]] from', ', present stem from', ', conjectured as from', ', partially from', ', likely a compound from', ', probably borrowed from', ', an unexpected development from', ', an early borrowing from', ', perhaps ultimately from', ', old dual from', ', borrowed in the 1200s from',  ', possibly borrowed from',  ', possibly ultimately from', ', most likely from', ', the form from', ', likely from', ', in turn borrowed itself from', ', apparently from', ', which was derived from', ', which was inherited from', ', which came from', ', which is borrowed from', ', ultimately a borrowing in West-Germanic from', ', replacing the original masculine and feminine nominative forms from', ', perhaps borrowed from' , ', [[ellipsis]] from', ', assumed from', ', adjectival form from', ', itself possibly from', ', but at any rate ultimately from',  ', possibly derived from', ', merged from', ', all ultimately from', ', root noun derived from', ', verbal noun from', ', by alteration from', ', shortened from', ', probably shortenings of a gram derived from', ', possibly related to or from', ', extended from', ', usually thought to be deverbal from', ', a name probably taken from', ', thought to be from', ', which in turn was formed from', ', a late 13th century loan from', ', probably adapted from', ', a semi-learned borrowing from', ', a noun use of an adjective from', ', diminutive from' , ', which comes from', ', probably derived from', ', a nominal use of an adjective from', ', back-formed from', ', variously from', ', the two components deriving from', ', which is in turn from',    }
make_regex('Primitive', 'Pr_from_connector', lambda content: content.startswith(',') and content.strip().endswith('from') and content.strip() in fromlist, kind='text')
#TODO: scan for ending in "stem of". also rewrite this as a comp
make_regex('Primitive', 'Pr_of_connector', lambda content: content.strip().endswith('of') and content.startswith(',') and not content.strip(', ').startswith('or ') and not any(exclude_char in content[1:] for exclude_char in '\n.;,') and 'calque' not in content and 'former' not in content and 'equivalent' not in content and 'later' not in content and 'elder' not in content and 'latter' not in content and 'ancestor' not in content and not content.strip().endswith('root as of') and not content.strip().endswith('root of') and not content.strip().endswith('source of') and not content.strip().endswith('origin of') and not content.strip().endswith('influence of') and not content.strip().endswith('version of') and not content.strip().endswith('variation of') and not content.strip().endswith('spelling of'), kind='text')
make_regex('Primitive', 'Pr_source_connector', lambda content: content.strip(', ').endswith('source') and not content[0] in ':;.]()' and not any(exclude_char in content for exclude_char in '\n.;'), kind='text')

make_regex('OR'        , 'Pr_pastward_connector_internal'  , [Pr_from_connector, Pr_of_connector, Pr_source_connector])
make_regex('Primitive' , 'Pr_not_related'                  , lambda content: not content.strip(', ').startswith('related') , kind='text')
make_regex('AND'       , 'Pr_pastward_connector'           , [Pr_pastward_connector_internal, Pr_not_related])


def _accept(text):
   return False

def _reject(text):
   return True

def _pastward_connector(text):
   accept, reject = _accept(text), _reject(text) 
#   if accept: 

   return not reject and accept

#make_regex('Primitive', 'Pr_pastward_connector', pastward_connector, kind='text')


####### THE REST OF THE BIG ONE 

make_regex('OR'        , 'Pr_etymon_mention'               , [Pr_etymon, Pr_mention])
make_regex('Primitive' , 'Pr_comma'                        , lambda content: content.strip()==','                          , kind='text')
make_regex('Pattern'   , 'P_equivalent_group_continuation' , [([Pr_comma, Pr_etymon_mention], '*')])
make_regex('Pattern'   , 'P_equivalent_group'              , [Pr_etymon_mention, P_equivalent_group_continuation])

# note: these aren't actually all compounds, because ', and' might just be an equivalence continuer. but we conservatively treat that as compound, i.e. allow the reference but don't continue.
make_regex('Primitive' , 'Pr_commaand'           , lambda content: content.strip()==', and'                  , kind='text')
make_regex('Primitive' , 'Pr_plus'               , lambda content: content.strip()=='+'                      , kind='text')
make_regex('OR'        , 'Pr_compound_connector' , [Pr_commaand, Pr_and, Pr_plus])
make_regex('Pattern'   , 'P_compound_segment'    , [Pr_compound_connector, Pr_etymon_mention])
make_regex('Pattern'   , 'P_compound_ender'      , [(P_compound_segment, '*')])
make_regex('NOT'       , 'Pr_big_ender'          , [Pr_compound_connector, Pr_comma, Pr_pastward_connector])

# this is a confusing way ; relying on big_ender to allow From. also potentially needlessly excluding things that go [not From] [mention], from {der|...}, because the ,from looks like connector but notFrommention doesn't start a match
make_regex('Primitive' , 'Pr_From'     , lambda content: content.split('\n')[-1].strip(', ') in ['From'] , kind='text')
make_regex('Pattern'   , 'P_big_start' , [[Pr_From, Pr_mention] |OR| [Pr_big_ender, Pr_etymon]])

## under what circumstances does abstract_regex match the same sequence multiple times? how does this relate to performance?
make_regex('Pattern', 'P_big', [P_big_start,  P_equivalent_group_continuation, ([Pr_pastward_connector, P_equivalent_group], '*'), P_compound_ender, Pr_big_ender])

def big_extractor(match):
   groups = [[match[0][-1]] + match[1][1::2]]
   for equivalent_group in match[2:-2][1::2]:
      groups.append([equivalent_group[0]] + equivalent_group[1][1::2])
   groups[-1].extend(thing[1] for thing in match[-2])
   return groups

def big_ref_extractor(match):
   for group in big_extractor(match): yield from group

Inference_object('reference', P_big, 'Etymology', big_ref_extractor, 'pastward')

def big_link_extractor(match):
   for pair in zip((groups := big_extractor(match)), groups[1:]):
      yield from product(*pair) 

Inference_object('link', P_big, 'Etymology', big_link_extractor, 'pastward')

