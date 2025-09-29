"""
exec(open('scanning/scan_words.py').read())

1. do the pastward sense finding always end in a pastmost? in otherwords, is the sense pastwards tree have as pastmosts a subset of wide pastmsot?
2. if so, and if you go sensewise futureward from the  the pastmosts senss, then do you get all the senses that were in pastward trunk senses? do you get more? currently we force only getting thoes...
really, the current thing is incorrect; we should include both the starting senses and the found senses. the question is whether going futureward from pastmost senses only, gets at least all the pastward senses starting from the original sense .

exec(open('src/radix.py').read())

word = str_Word('[*tpḗrsneh₂, ine-pro]')
Word_Parsed(word)

falling through to all mentioners for 
[lopsided, en] 
word = str_Word('[loppestre, ang]')
SQL_WORD_AllMentioningWords.Select(word)

word = str_Word('[lop, en]')
WordDirection_Givenrefwords(word, 'pastward')

for lword in SQL_WORD_AllMentioningWords.Select(word):
   print(Word_Terminallink(lword))

langs = counts.keys()
len(langs)
sort_lang = list(reversed(sorted(langs, key=lambda lang: len(counts[lang]))))
sort_lang = sorted(langs, key=lambda lang: len(counts[lang]))

for lang in sort_lang:
   print(lang, len(counts[lang]))

sort_lang[-50:]

[x for x in sort_lang[-100:] if x not in PIE_langcode_poset.domain]

for lang in reversed(sort_lang):
   print(len(counts[lang]), lang, Codelangs[lang])

suffix


"""

exec(open('src/precomputing/abstracted.py').read())

RED = (255, 80, 80) 

#mode:report&
def Word_Terminallink(word):
   return RGBtext_Terminalcolored(RED, f'\033]8;;http://localhost/word/lang:{word.lang}/{word.text}\033\\{word}\033]8;;\033\\')

count = 0
def FUN(word, immediate_pastwards):
   global count
   for past_word in immediate_pastwards:

      if word.lang not in ['la']:
         if PIE_langcode_poset.prior_to(word.lang, past_word.lang):
            print(Word_Terminallink(word), 'claimed comes from', Word_Terminallink(past_word))
            count+=1

   return []


to_do_1 = {'generator source':SQL_WORD_ImmediatePastwardset, 'function':FUN, 'target tables':[SQL_SANDBOX], 'message': '', 'printing': False, 'printing_args': False}

CALL([to_do_1, ])




'''

counts = {}
def FUN(word, immediate_pastwards):
   global counts
   counts.setdefault(word.lang, []).append(word.text)
   return []


see scratch6

for lang in PIE_langcode_poset_restricted.domain: 
   print(lang, Codelangs[lang], 

for lang in reversed(sort_lang):
   print(len(counts[lang]), lang, Codelangs[lang])

more than 10k, and in codelang:
{ 'en', 'la', 'es', 'it', 'ru', 'fr', 'pt', 'de', 'sv', 'gl', 'ca', 'pl', 'nl', 'lv', 'ro', 'el', 'nb', 'sh', 'mk', 'nn', 'grc', 'cs', 'uk', 'enm', 'bg', 'da', 'xcl', 'ga', 'ang', 'is', 'ast', 'hi', 'lt', 'cy', 'hy', 'got', 'fa', 'sa', 'gd', 'non', 'fro', 'sk', 'sq', 'fo', 'bn', 'af', 'dum', 'nrf', 'yi', 'oc', 'cu', 'goh', 'gmh', 'sl', }

exec(open('src/radix.py').read())

count_string = Read(RadixRootdir + '/scanning/lang_wordcounts.txt')
xxx = [x.strip().split(' ') for x in count_string.split('\n') if x.strip() != '']
xx = [(x[0], x[1], ' '.join(x[2:])) for x in xxx]
counts = {lang:count for count, lang, name in xx}

sorted_langs = sorted(PIE_langcode_poset_restricted.domain, key=lambda lang: int(counts[lang]))
for lang in sorted_langs:
   print(lang, Codelangs[lang], counts[lang])


'''

