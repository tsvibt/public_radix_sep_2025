def InfInherit(subheader, tokens):
   return PatternTokens_Matches(Ainflink, tokens) if subheader.startswith('Etymology') else []

Ainh = Primitive('Ainh', lambda tok: 
     tok['kind']=='reference' and 'lang' in tok['content'])
#and tok['content']['kind'] in ['inherited','mention', 'derived'])
Ainhchain = Primitive('Ainhchain', 
   lambda tok: tok['kind'] == 'text' and tok['content'] == ', from ')
Ainflink = Pattern('Ainflink', [Ainh, Ainhchain, Ainh])



#OLD
#make_regex kind an argument and lambda content:
make_regex(Primitive, 'Pr_link', lambda tok: 
     tok['kind']=='reference' and tok['content']['kind'] == 'link')

make_regex(Primitive, 'Pr_mention', lambda tok: 
     tok['kind']=='reference' and tok['content']['kind'] == 'mention')

make_regex(Primitive, 'Pr_whitespace', lambda tok: 
     tok['kind']=='text' and tok['content'].strip() == '')

make_regex(Primitive, 'Pr_seedesc', lambda tok: 
     tok['kind']=='reference' and tok['content']['kind'] == 'see descendants')

make_regex(Primitive, 'Pr_asterisks', lambda tok: 
               tok['kind']=='text' and '*' in tok['content'].split('\n')[-1] and tok['content'].split('\n')[-1].strip('* ') == '')

make_regex(Primitive, 'Pr_from', lambda tok: 
     tok['kind']=='text' and tok['content'].split('\n')[-1].strip(', ') in ['from', 'From'])

make_regex(Primitive, 'Pr_comma', lambda tok: 
     tok['kind']=='text' and tok['content'].strip()==',')

make_regex(Primitive, 'Pr_pastward_ref', lambda tok: 
     tok['kind']=='reference' and tok['content']['kind'] in {'derived',  'inherited', 'inflection of', 'borrowed'})

make_regex(Primitive, 'Pr_notplusstart', lambda tok: 
     tok['kind']=='text' and not tok['content'].strip().startswith('+'))


#maybe useful to get inferred links... none in Desc or Derived
#make_regex(Primitive, 'Pr_from_which', lambda tok: 
#     tok['kind']=='text' and 'from which' in tok['content'])
#Ref_Inference(Pr_from_which, 'Etymology', 0, 'futureward')

#todo: class link_inference  which gets links between 3rd parties, not sensedicte --> word

#hm. maybe for enm stuff, too many from inferences,we can equate guys. just go with the one or two main ones, or something? exclude their outlinks, in some sense? 
#https://en.wiktionary.org/wiki/left
#https://en.wiktionary.org/wiki/left
#https://en.wiktionary.org/wiki/value

#could treat these as like all sensese of one word..??


#not clear whether to accept these. some are valuable, eg. see english "value", where both enm guys value and valew show up anyway, so it's good to link them; but see https://en.wiktionary.org/wiki/left english, which links to enm luft, which is about lift not left.  https://en.wiktionary.org/wiki/lift
# in general we get these long lists of enm equivalents, suspicious. 
make_regex(Pattern, 'P_from_pastward_mention', [Pr_from, Pr_pastward_ref, ([Pr_comma, Pr_mention], '+')])
#make_regex(Pattern, 'P_from_pastward_from_mention', [Pr_from, Pr_pastward_ref, ([Pr_comma, Pr_pastward_ref], '+')])
Ref_Inference(P_from_pastward_mention, 'Etymology', -1, 'pastward')

make_regex(Pattern, 'P_pastward_or_mention', [Pr_pastward_ref |OR| Pr_mention])
#make_regex(Pattern, 'P_pastward_or_mention', [Pr_pastward_ref])
#make_regex(Pattern, 'P_from_pastward_from_mention', [Pr_from, Pr_pastward_ref, ([Pr_comma, Pr_pastward_ref |OR| Pr_mention], '*'), Pr_from, Pr_pastward_ref |OR| Pr_mention, ([Pr_comma, Pr_pastward_ref |OR| Pr_mention], '*')])
#make_regex(Pattern, 'P_from_pastward_from_mention', [Pr_from, Pr_pastward_ref, ([Pr_comma, P_pastward_or_mention], '*'), Pr_from, Pr_mention, ([Pr_comma, P_pastward_or_mention], '*')])
#make_regex(Pattern, 'P_from_pastward_from_mention', [Pr_from, Pr_pastward_ref, ([Pr_comma, Pr_pastward_ref |OR| Pr_mention], '*'), Pr_from, Pr_mention, ([Pr_comma, Pr_pastward_ref |OR| Pr_mention], '*')])


240203    18:53:42    
#def isPastward(ref):
#   return ref['kind'] in {'root', 'derived',  'inherited', 'inflection of','borrowed','suffix', 'prefix', 'affix', 'compound', 'blend', 'confix-stem', 'de-adj form of', 'plural of', 'verb form of', 'participle of', 'back-formation'} 
#def isFutureward(ref):
#   return ref['kind'] in {'descendant'}
#def RefDirection(ref):
#   return 'pastward' if isPastward(ref) else ('futureward' if isFutureward(ref) else None)
#def OLD_SensedictDirection_Refs(sensedict, direction):
#   plain_refs = filter(lambda ref: RefDirection(ref) == direction, Sensedict_Recognizedrefs(sensedict))
#   return list(plain_refs) + SensedictDirection_Inferredrefs(sensedict, direction)

# any of these usable? 
#Ref_Inference(Pr_link, 'Etymology', 0, 'futureward')


#Ref_Inference(Pr_link, 'Derived terms', 0, 'futureward')
Inference_object('ref', Pr_link, 'Derived terms', 0, 'futureward')
#seemingly all links are good in derived terms section??

#Ref_Inference(Pr_link, 'Extensions', 0, 'futureward')

#Ref_Inference(Pr_link, 'Descendants', 0, 'futureward')

# can't just take all mentions
# this doesn't really occur in Descendants:
#make_regex(Pattern, 'P_derived_test', [Pr_asterisks, Pr_mention])
#this occurs, but is rarely really a forward link.. perhaps occasionally a desc followed by an m?
#make_regex(Pattern, 'P_derived_test', [Pr_mention])
#apparently all links within descendants subheader are real? 


#Ref_Inference(P_asterisk_mention, 'Derived terms', 1, 'futureward')

#make_regex(Primitive, 'Pr_seedesc', lambda content: content['kind'] == 'see descendants', kind='reference')
#Ref_Inference(P_from_pastward_mention, 'Etymology', -1, 'pastward')
#TODO same but require specifically a startswith_comma or ; or . after the last one, to rule out +.... or just rule out + explicitly...
#BADDD because this includes lots of plusses.  maybe should force first to be parstward? doesn't clearly get 
#from {{der|en|fro|value}}, feminine past participle of {{m|fro|valoir}}, from {{der|en|la|valeō|valēre|be strong, be worth}},
#https://en.wiktionary.org/w/index.php?title=value&action=edit
#From {{der|nrf|fro|acent}}, from {{der|nrf|la|accentus}}, from {{m|la|ad}} + {{m|la|cantus||song}}.
#First attested in the 1570s. From {{der|en|fro|accoster}}, from {{der|en|VL.|accosto||to come alongside someone}}, from {{m|la|ad||near}} + {{m|la|costa||rib, side}}. Cognate with {{cog|es|acostar||to lie down, go to bed}}.
#First attested in mid 15th century. From {{inh|en|enm|acrewen}}, borrowed from {{der|en|fro|acreue|acreüe}}, past participle of {{m|fro|accreistre||to increase}}, from {{der|en|la|accrēsco||increase}}, from {{m|la|ad||in addition}} + {{m|la|crēscō||to grow}}.
#First attested around 1300. From {{inh|en|enm|acusen}}, from {{der|en|fro|acuser}}, from {{der|en|la|accūsō||to call to account, accuse}}, from {{m|la|ad|t=to}} + {{m|la|causa|t=cause, lawsuit, reason}}. Akin to {{m|en|cause}}. Displaced native {{cog|en||[[bewray#Etymology|bewray]]}}.
#test case for patterns in patterns (note: could be helpful for grouping!):
#make_regex(Pattern, 'P_from_pastward_from_mention', [P_pastward_or_mention])
# lump together things that are +-ed; if the first is an inheriting thing, so is the second. likewise if they are ,-ed. 
#if they are -ed, then infered links should also do the thing...
#wait no
#{der|en|gem-pro|*uz-|t=out}} + {{m|gem-pro|*bregdaną|t=to move, swing}}, from {{der|en|ine-pro|*bʰrēḱ-}}
#shouldn't say *uz- comes from bhrek



make_regex(Primitive, 'Pr_whitespace', lambda content: content.strip() == '', kind='text')


240203    23:41:48    
# Pattern, as in regular expressions.
# Example: p = Pattern('name', [a, b, c, (d, '+') |OR| e])
# which gives you a regex «abc(d+|e)»,
# where a, b, c, d and e are another patterns or primitives.
#
##Which allows you to write templates like these:

## Selecting
#table = Primitive('table', lambda token: token.type == 'table')
#column = Primitive('column', lambda token: token.type == 'column')
#columnExpr = Pattern('columnExpr', [(table, '*'), column])
#columnLiteralExpr = Pattern('columnExpr', [(table, '*'), column])
#listOfTables = Pattern('listOfTables', [table])
#listOfColumns = Pattern('listOfColumns', [columnExpr, ([column, columnExpr], '*'), (table, '?')])
#selectExpr = Pattern('selectExpr', [listOfColumns |OR| listOfTables])

#G_ref_inference_rules = {'pastward':[],
#                     'futureward':[],
#                     None:[]}
#G_link_inference_rules = {'pastward':[],
#                          'futureward':[],
#                          None:[]}


#def make_Inference(regex_object, header, link_extractor, kind, direction=None):
#   if isinstance(regex_object, Primitive):


#      self.kind,self.regex_object,self.header,self.extractor,self.direction = kind,regex_object,header,extractor,direction
#      print(self.name)
#      print(header)
#      print(tokens)


#
#class Ref_Inference:
#   def __init__(self, pattern, header, reference_index, direction=None):
#      self.name = 'Ref_Inference_' + header.split(' ')[0] + '_' + pattern.__str__().split('Pr_')[-1].split('P_')[-1]
#      globals()[self.name] = self
#      self.pattern = pattern if isinstance(pattern, Pattern) else make_regex(Pattern, 'patternized_' + pattern.__str__(), [pattern])
#      self.header, self.reference_index = header, reference_index
#      G_ref_inference_rules[direction].append(self)
#   def matches(self, header, tokens):
#      return (PatternTokens_Matches(self.pattern, tokens) if 
#               header.startswith(self.header) else [])
#   def refs(self, header, tokens):
#      return [match[self.reference_index]['content'] for match in self.matches(header, tokens)]
#
#class Link_Inference:
#   def __init__(self, pattern, header, list_link_extractor, direction=None):
#      self.name = 'Link_Inference_' + header.split(' ')[0] + '_' + pattern.__str__().split('Pr_')[-1].split('P_')[-1]
#      globals()[self.name] = self
#      self.header, self.list_link_extractor, self.pattern = header, list_link_extractor, pattern 
#      G_link_inference_rules[direction].append(self)
#   def matches(self, header, tokens):
#      return (PatternTokens_Matches(self.pattern, tokens) if 
#               header.startswith(self.header) else [])
#   def list_links(self, header, tokens): #list of pairs of lists of refs
#      return [self.list_link_extractor[match] for match in self.matches(header, tokens)]



#               for ref_inference_rule in G_ref_inference_rules[direction]

# scanning
#def Worddict_InferredlinksMatches(worddict):
#   return [(inference_rule.list_link_extractor(match), match, tokens)
#            for _, sensedict in worddict.items()
#            for header, tokens in sensedict.items()
#            for direction in ['pastward', 'futureward']
#            for inference_rule in G_link_inference_rules[direction]
#            for match in inference_rule.matches(header, tokens)]

# scanning, quasi- real links
#def Worddict_Inferredlinks(worddict):
#   return {(from_ref, to_ref, direction) 
#            for _, sensedict in worddict.items()
#            for header, tokens in sensedict.items()
#            for direction in ['pastward', 'futureward']
#            for inference_rule in G_link_inference_rules[direction]
#            for from_word, to_word in inference_rule.list_links(header, tokens)}

# various
#def Worddict_Inferred(worddict, inference_rules):
##def Worddict_Inferred(worddict, inference_rules=tokenlist_inference_rules):
#   links = []
#   for _, sensedict in worddict.items():
#      for header, tokens in sensedict.items():
#         for inference_rule in inference_rules:
#            links += [(link,inference_rule.name,Tokens_Text(tokens))
#                               for link in inference_rule.matches(header, tokens)]
#   return links


#UNUSED
#def Matchtokens_Text(tokens):
#   actual_tokens = fully_flatten(tokens)
#   return Tokens_Text(actual_tokens)

#### (start) everything here only used to define SensedictDirection_Targetwords





def Ref_Recognized(reference):
   return reference['kind'] not in ['unrecognized', 'bad reference']

def Sensedict_AllRefs(sensedict):
   return [token['content'] for _, tokens in sensedict.items() 
           for token in tokens if token['kind'] == 'reference']

def Sensedict_Recognizedrefs(sensedict):
   return filter(Ref_Recognized, Sensedict_AllRefs(sensedict))


#### (end)

# uh oh. 
#* {{l|ine-pro|*h₂éd|*h₂ed}}{{l|ine-pro||-bʰer-}}<ref name="EIEC">{{R:ine:EIEC|head=Sacrifice|page=496}}</ref><ref name="Oxford">{{R:ine:Mallory:2006|page=413}}</ref>
#this is from bher article... in the derived terms section. how do we avoid thinking that bher is the root of h2ed??
#https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/b%CA%B0er-?useskin=vector-2022#Proto-Indo-European
#*h₂ed-bʰer-
#ah. just dont allow emmediately adjacet l


240204    14:03:46    
#   def resultkinds_fun(self, resultkinds):
#      return lambda header, tokens: [{'matches':self.matches, 'extractions':self.extractions}[resultkind](header, tokens) for resultkind in resultkinds]

#   def extractions(self, header, tokens):
#      return list(map(self.match_extraction, self.matches(header, tokens)))


240206    03:41:12    
make_regex(Primitive, 'Pr_right_adjacent', lambda content: content[0] not in ' ,;.:+)\'"/\n*', kind='text')
make_regex(Pattern, 'P_link_adjacent', [Pr_link, Pr_right_adjacent])
EXTRACTOR = lambda toks: [[toks[0]], [toks[1]]]

#doesn't really happen:
Inference_object('link', P_link_adjacent, 'Descendants', EXTRACTOR, 'pastward')

#doesn't really happen:
make_regex(Primitive, 'Pr_right_adjacent', lambda content: len(content) > 0 and content[0] not in ' ,;.:+)\'"/\n*|&', kind='text')
make_regex(Primitive, 'Pr_left_adjacent', lambda content: len(content) > 0 and content[-1] not in ' ,;.:+()\'"/\n*|&', kind='text')
#make_regex(Pattern, 'P_link_adjacent', [Pr_link, Pr_right_adjacent])
make_regex(Pattern, 'P_link_adjacent', [Pr_left_adjacent, Pr_link ])
EXTRACTOR = lambda toks: [[toks[0]], [toks[1]]]
#Inference_object('link', P_link_adjacent, 'Descendants', EXTRACTOR, 'pastward')
#Inference_object('link', P_link_adjacent, 'Derived terms', EXTRACTOR, 'pastward')
Inference_object('link', P_link_adjacent, 'Derived terms', EXTRACTOR, 'pastward')
#Inference_object('link', P_adjacent_link, 'Descendants', EXTRACTOR, 'pastward')


240206    04:47:52    
# barely happens (first 80k, only plat,en 
make_regex(Pattern, 'P_etymondash_comma_mention', [ Pr_etymons_dash, Pr_commaand, Pr_somewords])
#problem: this etymondash , etymondash thing can either be an ordered thing, or an unordered thing. 

#some like this exist:
#make_regex(Pattern, 'P_etymondash_comma_mention', [ Pr_etymons_dash, Pr_and, Pr_etymons_dash])

# hmmm...
#in: [rite, en]
#{{root|en|ine-pro|*h₂er-}}
#Via {{der|en|enm|-}} and {{der|en|fro|-}}, from {{der|en|la|ritus}}.


240206    05:58:54    

      if kind == 'ref':
         if type(extractor) == int:
            self.match_extraction = lambda match: match[extractor]
         else:
            self.match_extraction = lambda match: [token for token in extractor(match)]
      else:
         self.match_extraction = extractor

240209    23:56:59    






#TODO GO THROUGH to get the useful stuff!


make_regex(Primitive, 'Pr_from', lambda content: content.split('\n')[-1].strip(', ') in ['from', 'From'], kind='text')

make_regex(Primitive, 'Pr_comma', lambda content: content.strip()==',', kind='text')

make_regex(Primitive, 'Pr_pastward_ref', lambda content: content['kind'] in {'derived',  'inherited', 'inflection of', 'borrowed'}, kind='reference')
make_regex(Pattern, 'P_from_pastward_mention', [Pr_from, Pr_pastward_ref, ([Pr_comma, Pr_mention], '+')])
Inference_object('ref', P_from_pastward_mention, 'Etymology', -1, 'pastward')

#####

# potential source of ineffeciency? replace with manual primitive combination? 
make_regex(Pattern, 'P_pastward_or_mention', [Pr_pastward_ref |OR| Pr_mention])

make_regex(Primitive, 'Pr_notplusstart', lambda content: not content.strip().startswith('+'), kind='text')

make_regex(Pattern, 'P_from_pastward_from_mention', [Pr_pastward_ref, ([Pr_comma, P_pastward_or_mention], '*'), Pr_from, Pr_mention, ([Pr_comma, P_pastward_or_mention], '*'), Pr_notplusstart])

#Inference_object('link', P_from_pastward_from_mention, 'Etymology', EXTRACTOR, 'pastward')

#we allow ':' because they look like {{der|nb|la|omnibus||for all}}, [[Appendix:Glossary#dative|dative]] plural of {{m|la|omnis||all}},
# some '.' are ok, eg. :
#from {{inh|en|ang|nīehsta}}, {{m|ang|nīehste}}, etc., inflected forms of {{m|ang|nīehst|t=nearest, next}},
# {{bor|en|de|Nickel}}, first used in a text by the Swedish mineralogist [[w:Axel Fredrik Cronstedt|Axel F. Cronstedt]] as an abbreviation of {{m|de|Kupfernickel||a mineral containing copper and nickel}}
#(extremeley rare, fixed) {{bor|en|it|dilettante}}, prop. present participle of {{m|it|dilettare||to delight}},
#  (extremely rare, fixed) {{m|la|umbrella|t=parasol, sunshade}}, dim. of {{m|it|ombra|t=shade}}
# but mostly bad. 
#make_regex(Primitive, 'Pr_of', lambda content: content.strip().endswith('of') and content.startswith(',') and ';' in content[1:], kind='text')

#could put length restrictuion, but, apparently they're good even when long?
# unfortunately, there are some bad "froms":
#in: [Andorra, es]
#Probably from a {{der|es|eu|-}} word {{m|eu|andurrial|t=shrub-covered land}}, but it may come from {{der|es|ar|درا|الدُرَّا|t=the forest}} or {{m|es|andar|t=to walk}}.
#in: [Chile, es]
#From {{der|es|qu|chiri|t=cold}} or {{m|qu|chili|}}, or from {{der|es|arn|chilli|t=seagull [[Larus dominicanus]]}}.

#in addition  to + , use 'and'?
#in: [talent, enm]
#From {{bor|enm|fro|talent}} and {{inh|enm|ang|talente}}, both from {{der|enm|la|talentum}}, from {{der|enm|grc|τάλαντον}}.
#in addition to comma, allow or?

# could compress, like : comma, then maybe possibly ultimately etc. then maybe itself, then maybe also 
fromlist = {', from', ',  from', ', ultimately from',', possibly from',', itself from',', itself also from',', either from',', borrowed from',', in turn from',', inherited from',', probably ultimately from',', formed from',', developed figuratively from',', derived from',', probably from',', descended from',', originally from',', all from',', extracted from',', metathesis from',', contracted from',', presumably from',', a borrowing from',', itself derived from',', which ultimately comes (by dissimilation) from',', in part from',', itself a borrowing from',', traditionally derived from',', which is from',', itself probably from',', likely derived from',', formed either from',', both from',', perhaps from',', syncopated from',', in turn probably from',', which was formed from',', ultimately derived from',', itself borrowed from',', borrowing from',', further etymology uncertain but probably ultimately from',', itself a verbal noun from', ', an irregular formation from', ', partly from', ', adjective form from', ', which was from', ', a denominative verb from', ', coined by Plato from', ', from an unattested adjective derived from', ', which derives from', ', usually assumed to be from', ', denominative from', ', both ultimately from', ', deverbal from', ', maybe from', ', possibly (see above) from', ', [[metathesis]] from', ', present stem from', ', conjectured as from', ', partially from', ', likely a compound from', ', probably borrowed from', ', an unexpected development from', ', an early borrowing from', ', perhaps ultimately from', ', old dual from', ', borrowed in the 1200s from',  ', possibly borrowed from',  ', possibly ultimately from', ', most likely from', ', the form from', ', likely from', ', in turn borrowed itself from', ', apparently from', ', which was derived from', ', which was inherited from', ', which came from', ', which is borrowed from', ', ultimately a borrowing in West-Germanic from', ', replacing the original masculine and feminine nominative forms from', ', perhaps borrowed from' , ', [[ellipsis]] from', ', assumed from', ', adjectival form from', ', itself possibly from', ', but at any rate ultimately from',  ', possibly derived from', ', merged from', ', all ultimately from', ', root noun derived from', ', verbal noun from', ', by alteration from', ', shortened from', ', probably shortenings of a word derived from', ', possibly related to or from', ', extended from', ', usually thought to be deverbal from', ', a name probably taken from', ', thought to be from', ', which in turn was formed from', ', a late 13th century loan from', ', probably adapted from', ', a semi-learned borrowing from', ', a noun use of an adjective from', ', diminutive from' , ', which comes from', ', probably derived from', ', a nominal use of an adjective from', ', back-formed from', ', variously from', ', the two components deriving from', ', which is in turn from',    }

#exclude_froms = {', or from', ', but it may come from', ', or otherwise taking from', ', and partly from', ', or alternatively from', ', is inherited from',  ', or more likely from', ', the last from', }
#these ALWAYS start with a comma!
#make_regex(Primitive, 'Pr_fromend', lambda content: content.startswith(',') and content.strip().endswith('from') and not any(exclude_char in content[1:] for exclude_char in '.;,') and content.strip() in fromlist, kind='text')

#TODO 
make_regex(Primitive, 'Pr_fromend', lambda content: content.startswith(',') and content.strip().endswith('from') and content.strip() in fromlist, kind='text')

#could do something with ', the last from'

#TODO 
make_regex(Primitive, 'Pr_of', lambda content: content.strip().endswith('of') and content.startswith(',') and not any(exclude_char in content[1:] for exclude_char in '\n.;,') and 'calque' not in content, kind='text')


#TODO 
#make_regex(Pattern, 'P_of_mention', [P_pastward_or_mention, Pr_fromend, P_pastward_or_mention])
#make_regex(Pattern, 'P_of_mention', [P_pastward_or_mention, Pr_of, P_pastward_or_mention])
#Inference_object('link', P_of_mention, 'Etymology', EXTRACTOR, 'pastward')


#seems that sometimes m and m is like a compaound
#{{lbor|en|la|meticulōsus|t=full of fear, timid, fearful, terrible, frightful}}, from {{m|la|metus||fear}} and {{m|la|-culōsus}}, extracted from {{m|la|perīculōsus||perilous}}. Sense of “characterized by very precise, conscientious attention to details” is a {{sl|en|fr|méticuleux|nocap=1}}.
#Borrowed from {{bor|en|sh|Jugoslavija}}, in turn from {{m|sh|jug||south}} and {{m|sh|slavija||''[[Slavia]]'', the land of the [[Slav]]s}}. Literally, ''the land of the [[Wikipedia:South Slavs|South Slavs]]''.
#From {{bor|nb|fr|jour||day, daylight, light}}, from {{der|nb|fro|jorn}}, {{m|fro|jor||day}}, from {{der|nb|la|diurnum|diurnum [tempus]}}, from {{m|la|diurnus||of the day, daily}}, from earlier ''*diusnus'', from '''both''' {{m|la|diūs}}, from {{der|nb|itc-ola|-}}, from {{der|nb|itc-pro|*djous||day, sky; Jupiter}} from {{der|nb|ine-pro|*dyḗws||sky, heaven; sky god}}, from earlier {{m|ine-pro||*dyéws}}, from {{m|ine-pro|*dyew-||to be bright; sky, heaven}} and {{m|ine-pro|*s|pos=creates nouns}} + '''and''' from {{m|la|-nus|pos=forms adjectives}}, from {{der|nb|itc-pro|*-nos}}, from {{der|nb|ine-pro|*-nós||forms verbal adjectives}}.


# while der and der is alternatives? like a diamond? 
#From {{inh|en|enm|anden}}, from {{inh|en|ang|andian||to be envious or jealous, envy}} and {{der|en|non|anda||to breathe}}; both from {{der|en|gem-pro|*anadōną||to breathe, sputter}}. Cognate with {{cog|de|ahnden||to avenge, punish}}, {{cog|da|ånde||to breathe}}, {{cog|sv|andas||to breathe}}, {{cog|is|anda||to breathe}}. See above.
#From {{inh|en|enm|ande}}, from {{inh|en|ang|anda||grudge, enmity, malice, envy, hatred, anger, zeal, annoyance, vexation; zeal; injury, mischief; fear, horror}} and {{der|en|non|andi||breath, wind, spirit}}; both from {{der|en|gem-pro|*anadô||breath, anger, zeal}}, from {{der|en|ine-pro|*h₂enh₁-||to breathe, blow}}.
#From {{inh|en|enm|pees}}, {{m|enm|pes}}, {{m|enm|pais}}, borrowed from {{der|en|xno|peis}} and {{der|en|fro|pais||peace}}, from {{der|en|la|pāx||peace}}, from {{der|en|ine-pro|*peh₂ḱ-||to fasten, stick, place}}, related to {{cog|la|pacīscor||agree, stipulate}}, {{cog|la|pangō||fasten, fix}}; see {{l|en|pact}}. Displaced native {{ncog|ang|sibb}} and {{m|ang|friþ}}.
#Borrowed from {{bor|en|de|Akronym}}, from {{der|en|grc|ἄκρον||[[end]], [[peak]]}} and {{m|grc|ὄνυμα||[[name]]}}, equivalent to {{confix|en|acro|onym|t1=[[high]]; [[beginning]]|t2=[[name]]}}.&lt;ref name=oed/&gt; Modelled after {{m|de|Homonym}} and {{m|de|Synonym}}, first attested in German in the early 1900s&lt;ref&gt;Gerhard Stilz, ''Studien zur englischen Philologie, Nummer 21'', Niemeyer., 1905&lt;/ref&gt; and in English in 1940.&lt;ref name=oed&gt;[http://www.oed.com/view/Entry/1844 &quot;acronym, ''n.''&quot;], in the ''Oxford English Dictionary'', Oxford: Oxford University Press.&lt;/ref&gt;
#From {{der|en|enm|Duch||German, Low German, Dutch}}, from {{der|en|gml|dütsch}}, {{m|gml|düdesch||German, Low German, Dutch}} and {{der|en|dum|dutsch|dūtsch}}, {{m|dum|duutsc||German, Low German, Dutch}}, from {{der|en|gmw-pro|*þiudisk}}, from {{der|en|gem-pro|*þiudiskaz||of one’s people}}, derived from {{m|gem-pro|*þeudō||people}}, from {{der|en|ine-pro|*tewtéh₂}}. {{doublet|en|Deutsch|tuath|}}.
#From {{der|ro|sh|krap}} and {{der|ro|bg|крап}}.
#From {{der|nn|la|pensum}}, via {{bor|nn|en|peso}} and {{der|nn|es|peso}}.

#eventaully could also use these:
#   From {{der|en|xno|-}} and {{der|en|fro|pincil}}
#From {{inh|wym|gmh|-}} and {{inh|wym|goh|hunt}}.
#From {{inh|cs|zlw-ocs|man}}, from {{der|cs|gmh|-}} and {{der|cs|goh|man}}.

#TODO 
make_regex(Primitive, 'Pr_and', lambda content: content.strip() == 'and', kind='text')
#make_regex(Pattern, 'P_and_mention', [P_pastward_or_mention, Pr_and, P_pastward_or_mention])
#Inference_object('link', P_and_mention, 'Etymology', EXTRACTOR, 'pastward')


make_regex(Primitive, 'Pr_nowords', lambda content: 'wordtexts' in content and content['wordtexts'] == [] and content['kind'] != 'cognate', kind='reference')
make_regex(Primitive, 'Pr_somewords', lambda content: 'wordtexts' in content and content['wordtexts'] != [] and content['kind'] != 'cognate', kind='reference')
make_regex(Pattern, 'P_nowords_and_somewords', [Pr_nowords, Pr_comma, Pr_somewords])
#Inference_object('link', P_nowords_and_somewords, 'Etymology', EXTRACTOR, 'pastward')

make_regex(Primitive, 'Pr_commaand', lambda content: content.strip() == ', and', kind='text')
#make_regex(Primitive, 'Pr_etymons', lambda content: content['kind'] in G_refdict_main_etymons, kind='reference')
make_regex(Primitive, 'Pr_etymons_dash', lambda content: content['kind'] in G_refdict_main_etymons and content['text'].split('|')[3].split('}}')[0].strip()=='-', kind='reference')
make_regex(Primitive, 'Pr_mention_dash', lambda content: content['kind'] == 'mention' and content['text'].split('|')[3].split('}}')[0].strip()=='-', kind='reference')
#TODO
#so can this be taken as ordered?


# rare but maybe good?
#make_regex(Pattern, 'P_etymondash_comma_mention', [ Pr_etymons_dash, Pr_comma, Pr_somewords])

#these actually seem good, with the ordered extractor? not totally sure,seems kinda rare and a bit fraught maybe. 
#make_regex(Pattern, 'P_etymondash_comma_mention', [ Pr_somewords, Pr_and, Pr_somewords])

make_regex(Pattern, 'P_etymondash_and_somewords', [ Pr_etymons_dash, Pr_and, Pr_somewords])
def LangLang_Descendant(lang1, lang2):
   return lang1 in PIE_langcode_poset.all_lefts.get(lang2, set()) 
def TokTok_Descendant(tok1, tok2):
   return LangLang_Descendant(tok1['content']['lang'], tok2['content']['lang'])

def copy_wordtexts(tok1, tok2):
   result = copy.deepcopy(tok1)
   result['content'].update({'wordtexts':tok2['content']['wordtexts']})
   return result
#   return {**tok1, **{'content':{**tok1['content'],** {'wordtexts':tok2['content']['wordtexts']}}}} 

dash_words_REF_EXTRACTOR = lambda toks: [copy_wordtexts(toks[0], toks[2])] if TokTok_Descendant(toks[0], toks[2]) else []
Inference_object('ref', P_etymondash_and_somewords, 'Etymology', dash_words_REF_EXTRACTOR, 'pastward')

# list of pairs of refs, i guess
dash_words_EXTRACTOR = lambda toks: [(copy_wordtexts(toks[0], toks[2]), toks[2])] if TokTok_Descendant(toks[0], toks[2]) else []
Inference_object('link', P_etymondash_and_somewords, 'Etymology', EXTRACTOR, 'pastward')

#make_regex(Primitive, 'Pr_From', lambda content: content.split('\n')[-1].strip(', ') in ['From'], kind='text')






# ok... so dashes. if the wordtxts is just a dash, then what? well first of all... we want to have this word sort of exist, like it should get to have pastmosts and such. it should show up in reports. it should get linked to by the worddict word. 
#so yeah,..... well.... wait, that can be done in reallinks, right? i mean. all the links come from inferences. so just... 


#exclude periods
#{{m|ine-pro|*telh₂-}}. The stem of {{m|la|lātus}}

# rquire comma start

# length not > 6 words or so

# exclude more commas? exclude ;?
#om {{bor|en|frm|Madagascar}}, from ''Madageiscar'', popularly reputed as a corrupted transliteration of {{m|en|Mogadishu}}


# exclude calque
#From {{der|da|fr|accent}}, from {{der|da|la|accentus}}, a calque of {{der|da|grc|προσῳδία|gloss=prosody, accent}}.


#from '''both''' ... '''and'''
#From {{bor|nb|en|absorbent}}, from {{der|nb|la|absorbēns||swallowing, absorbing}}, present active participle of {{m|la|absorbeō||absorb}}, from '''both''' {{m|la|ab-||from, away from, off}}, from {{m|la|ab||from, away from, on, in}}, from {{der|nb|itc-pro|*ab}}, from {{der|nb|ine-pro|*h₂epó||off, away}}, + '''and''' from {{m|la|sorbeō||I suck in, drink up}}, from {{der|nb|itc-pro|*sorβeō||to suck in}}, from {{der|nb|ine-pro|*srobʰéyeti||to be sipping, sucking}}, from {{m|ine-pro|*srebʰ-||to sip, gulp, suck (in)}} and {{m|ine-pro|*-éyeti}}, from {{m|ine-pro|*-yeti|pos=creates transitive imperfective verbs}}.


#, formed from
#From {{inh|en|enm|abstract}}, borrowed from {{der|en|la|abstractus}}, perfect passive participle of {{m|la|abstrahō||draw away}}, formed from {{m|la|abs-||away}} + {{m|la|trahō||to pull, draw}}. The verbal sense is first attested in 1542.

#then from either , or from
#From {{inh|en|enm|abusen}}, then from either {{der|en|fro|abus||improper use}}, or from {{der|en|la|abūsus||misused, using up}}, perfect active participle of {{m|la|abūtor||make improper use of, consume, abuse}}, from {{m|la|ab||away}} + {{m|la|ūtor||to use}}.&lt;ref name=WI3&gt;{{R:MW3 1976|page=8}}&lt;/ref&gt; Equivalent to {{prefix|en|ab|use}}.

#(From + mention) or Pr_pastward_ref
#alternatives continuator (comma, or), P_pastward_or_mention
#from or other chainer (participle of, etc)
#([Pr_comma, ], '*'), Pr_from, Pr_mention, ([Pr_comma, P_pastward_or_mention], '*'), Pr_notplusstart])


# HAVE tO EXCLUDE periods.
#allow "or" to contiue the thing, like comma?

#make_regex(Pattern, 'P_mention_comma', [Pr_mention, Pr_comma])
#Inference_object('link', P_mention_comma, 'Etymology', EXTRACTOR, 'pastward')

#EXTRACTOR = lambda toks: ([toks[0]], [toks[1]])
#Link_Inference(P_from_pastward_from_mention, 'Etymology', EXTRACTOR, 'pastward')

#current guess: pastwardsnses should transmit up to and include +, but then it stops there. then when we go forward from pastmosts, weu exclude the pastmosts that are specially marked as too big, eg the root of ad-, un-, -ed, etc etc 
# still not possible to look futureward from ad-.... not even clear what's desired...

#{der|en|gem-pro|*uz-|t=out}} + {{m|gem-pro|*bregdaną|t=to move, swing}}, from {{der|en|ine-pro|*bʰrēḱ-}}
#is there some solid general way to still infer from bregdana to bhrek, without infereing from uz to bhrek?

#, derived from
#, possibly from 
#, feminine past participle of

'''
so....
the start could be from, or From only (to avoid when the heritage of a non-inh word is given); so maybe just either From, or inh/der/bor, to start. Then, we can continue until plus. we should perhaps allow multiple plusses, but they do end the thing, else we'd have "ad comes from tract"
do we want to be excluding a bunch of ME things..?
we want to extract all the lists, and then each sequential pair gives all crosslinks, i think?? this seems like quit a lot. 
allow different interstiial, eg feminine past participl... how to find? search for ,...of? and ,...from?
how to deal with inefficiency...

how to do extraction...
'''


240210    13:25:59    

is this acceptable?

in: [last, sv]
{'text': '{{der|sv|gem-pro|*lahaną|t=to reproach, blame}}', 'kind': 'derived', 'inheritor lang': 'sv', 'lang': 'gem-pro', 'wordtexts': ['*lahaną']}

From {{inh|sv|gmq-osw|laster}} (Old Icelandic {{m|non|lǫstr}}), from {{inh|sv|non|löstr}}, from the root of {{der|sv|gem-pro|*lahaną|t=to reproach, blame}}, see also {{cog|goh|lastar||vice}}.


240210    20:45:03    

make_regex(Pattern, 'P_mfromm', [Pr_mention, Pr_pastward_connector, Pr_general_pastward_ref])
Inference_object('ref', P_mfromm, 'Etymology', -1, 'pastward')


240210    22:16:16    
wai wai wait. so ", and" is sometimes like compound / +:
   From {{der|en|pt|Brasil}}, from {{m|pt|brasil||brazilwood}}, originally ‘red like an ember’, from {{m|pt|brasa||ember}}, ultimately from {{der|en|gem-pro|*brasō||gleed, crackling coal}}, and {{m|pt|-il||-ile, -like, -y}} from {{der|en|la|-īlis||adjective suffix}}.{{att|en|Does it really come from &quot;Brasil&quot; and got its spelling changed, or was it taken from Portuguese back when it was still spelt &quot;Brazil&quot;?}}
   From {{der|en|la|Iuppiter|Iūpiter|t=father Jove}}, from {{der|en|itc-pro|*djous patēr|lit=sky father}} (cognate with {{cog|grc|Ζεύς πάτερ|Ζεῦ πάτερ|t=father Zeus}}), from {{m|itc-pro|*djous|t=day, sky}} + {{m|itc-pro|*patēr|t=father}}, from {{der|en|ine-pro|*dyḗws|lit=the bright one}}, from {{m|ine-pro|*dyew-|t=to be bright, day sky}}, and {{m|ine-pro|*ph₂tḗr|t=father}}. {{doublet|en|Dyaus Pita}}.


240214    03:45:23    

#make_regex(Pattern, 'P_big', [P_big_start,  P_equivalent_group_continuation, ([Pr_pastward_connector, P_equivalent_group], '+'), P_compound_ender, Pr_big_ender])

#make_regex(Primitive, 'Pr_the_of', lambda content: content.startswith(', the origin') and content.endswith('of '),kind='text')
#make_regex(Primitive, 'Pr_the_of', lambda content: any(x in content for x in ['stem of', 'root of', 'origin of', 'source of']) and 'from' not in content,kind='text')
#make_regex(Pattern, 'P_mention_the_of_mention', [Pr_etymon_mention, Pr_the_of, Pr_etymon_mention])
#
#Inference_object('ref',P_mention_the_of_mention , 'Etymology', -1, 'pastward')

maybe good but very rare
make_regex(Primitive, 'Pr_connected_to', lambda content: content.endswith('Possibly connected to '), kind='text')
make_regex(Pattern, 'P_connected_mention', [Pr_connected_to, Pr_mention])
Inference_object('ref', P_connected_mention, 'Etymology', -1, 'pastward')

