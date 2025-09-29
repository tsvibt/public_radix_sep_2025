'''
exec(open('src/scripts/make_subuniverse.py').read())
python src/scripts/make_subuniverse.py
/Users/tbt/radix/wiktionaries/40k-initial/SUBUNIVERSE__40k-initial__elephant_24.09.14-03_06_47.xml
'''
exec(open('src/radix.py').read())

def pageify(title, text): return f'<page><title>{title}</title>{text}</page>'

#for gramtext in ['elephant']:
for gramtext in ['handy']:

   subuniverse_file = f'{Wiktionary.directory}SUBUNIVERSE__{Wiktionary.main_name}__{gramtext}_{GetTimestamp()}.xml'
   gram = Gram(gramtext, 'en')

   subuniverse_domain = set()
   print(f'getting all grams for {gram}')
   for word in Gram_GivensOrPlaceholder(gram):
      for pastmost_word in Wordposet_Ulteriormostwords(Word_Pastwardwordposet(word)):
         for future_gram in GramDirection_Stricts(word.gram, 'futureward'):
            subuniverse_domain.add(future_gram)
            subuniverse_domain.update(Gram_AllMentioningGrams(future_gram))

   listed_domain = list(subuniverse_domain)
   print('done getting all grams')

   def gramtitle_articleText(gramtitle):
      if not globals().get('G_Server_mode', False): print(gramtitle, end=' ')
      xmls = Aggregator()
      if (xml := _Gramtitle_XML.Get(gramtitle)): xmls << pageify(gramtitle, xml)
      for redirected_gramtitle in Dict_Reversed(DB._cached_Gramtitle_Redirect).get(gramtitle, set()):
         xmls << pageify(redirected_gramtitle, f'<redirect title="{gramtitle}">')
      return xmls()

   print('writing text')
   chunk_size = 10000
   with open(subuniverse_file, 'a') as file:
      for i in range(0, len(listed_domain), chunk_size):
         print(f'on {i} of {len(listed_domain)}')
         chunk = ''.join(gramtitle_articleText(Gram_Gramtitle(this_gram)) for this_gram in listed_domain[i:i+chunk_size])
         file.write(chunk)

   print('done, written to:')
   print(subuniverse_file)
   if not globals().get('G_Server_mode', False):
      import pyperclip
      pyperclip.copy(subuniverse_file.split('/')[-1])

   WIPE_GLOBALCACHES()


