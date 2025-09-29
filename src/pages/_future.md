
donate; develop; edit wiktioanry
i'll write about problems more if anyone says they are interested
will be open source hopefully

If you're interested in helping, see å_assistå.

see å_visionå.

## open source

I plan to open source the code, but first I'd need some help making sure the server is reasonably secure-ish. At that point, it will be possible to run radix on any machine with enough memory (the database is large: some tens of GBs).

## other uses 

theb ackend has ltos fo stuff. potentaily uses:
other uses that i'm not pursuing:

* stats
* tools for finding errors in wiktionary
   * things that say the wrong inheritor language
   * parse errors with {{ and }}
   * words that have futureward links that go backwards in language -time. 
   * entries that have missing senses. e.g. angel angle.
   * also pressure for wanting the missing entries, eg by making radix pages worse...
   * tools for looking at glosses and noticing missing sense, eg pie bher. ? 


## key problems 

See the discussion of errors in å_warningå. 

* in general, there is quite a lot of jank, especially in adhoc partial implementartion of wiktionary stuff. 

* in general, there's a lot of info that is left on the table
* in general, there's a lot of info that's somewhat relied on but shouldn't be 
* in general, there's a lot of features that can simply be mirrored from wiktionary , eg. displaying IPA , etc

* Dealing with sense/etymon/reflex disambiguation. 
   * A word (here meaning "a string of characters, paired with a language") can have multiple senses. For example, "[hub](https://en.wiktionary.org/wiki/hub)" means "the central part of a wheel" and also means "a computer networking device connecting several Ethernet ports". These usages have the same etymon. 
   * Some words have senses (reflexes) that have distinct etymons. For example, "[weave](https://en.wiktionary.org/wiki/weave)" has two etymonically unrelated reflexes, one like in "weave a hat", cognate with "web", the other like in "weave through the crowd", cognate with "vibrate". 
   * Wiktionary links that point at a word don't usually specify which reflex they are pointing at. For example, Proto-West Germanic "[weban](https://en.wiktionary.org/wiki/Reconstruction:Proto-West_Germanic/weban)" has this link: {{desc|en|weave}}. It points at "weave" but doesn't say which one. Since one of the etymology sections in the "weave" article links to "weban", radix should be able to disambiguate in this case, but in many cases there is unresolved ambiguity.
   * Unresolved reflex/etymon disambiguation means that radix has to make a bad choice: either we show too much by showing words that are not cognate with the starting word, or we show too little by leaving out cognates. 
   * I don't know to what extent senseids currently cover ambiguities, but I think it's far from complete. 
   * Ultimately I think much of the solution is 1. implement [senseid](https://en.wiktionary.org/wiki/Template:senseid)s/[etymid](https://en.wiktionary.org/wiki/Template:etymid)s in radix, and 2. add senseids/etymids and id= parameters everywhere they're needed in  wiktionary. 
   * However, this doesn't solve the problem of wiktionary, and our understanding of etymology, being incomplete. In some cases it would be good to discern that there are missing senses. TODO e.g. bher. and in this caes we want to have more tools for identifying when a reference to a word isn't refering to any senses given for that word. so for example, looking at glosses and definitions, or looking at whole sets of these. possibly ask eLLLMs?

* it's annoying that the ordering is nondeterministic

* dealing with stuff.... e.g. fero / lat; -phagon vs edo eat

* displaying poset
   * fundamentally poset ish
   * diamonds ; derivation vs inheritance with -er etc
   * "alternative forms"
   * middle english

* cutting down on display
   * pruning ; how to do better? 

* system for broken dumps https://phabricator.wikimedia.org/T365155 ideally something like , we get the stable release when it's > 1 mo old, to give wikt ppl time to notice problems, (i.e. assume it's good); and then we get the latest one daily or weekly or something; and we check to see if any guys nuked (absent, empty, implausibly downsized); if so we use the old version. 

## Some improvements:

* Make the server good (able to handle whatever interest there is, secure, fast). I think there should be one in North America.

* Make the computation that builds the database more efficient. I'd guess the main thing here is to parallelize a bunch of stuff. (The computation is very parallelizable and I've already optimized it a lot in other ways.)

* Enable more languages. 
   * Currently radix is mostly restricted to Indo-European languages. 
   * At the moment radix doesn't allow displaying endpoint cognates in more than just a few languages (although the architecture is almost all there).

* Improve the interface. E.g.:
   * Improve colors. Currently there are just a handful of languages with defined colors. There's an issue here where on the one hand there's aesthetics, which might ask for related languages to have similar colors; but on the other hand, if I want to quickly visually scan for words in a specific language, I want those words to stick out. There might be some better method (e.g. having a setting to highlight words in some language, etc.).
   * Have customizable colors and such.
   * There's probably other cool things you could do, e.g. have a more poset-ish display, or arrange the words in the trees into columns according to the age of their language or something.

* dealing with uncertainty... possibly, probably, either or....

* AFFIXES

* add other templates... or ideally integrate with wiki


* once capability is added to show various versions of non-pruning, can explain these on the doc pages. 

* Many more things, big and small; e.g. better integrating with wiktionary's code (e.g. lua stuff), better mirroring how wiktionary handles templates, caching frequently viewed pages, better styling, customizable styling, reactive loading of different parts, etc. 

* integrate other dictionaries.... other language wiktionaries, and other docs such as PIE dicts? 

* we should indicate / show whcih senses; and when three's unresolved ambiguty

* shoudl show uncertainty somewhoie

*  many cases where there's more to be squeezed from wiktionary as-is. eg. the PIE origin of "word" is https://en.wiktionary.org/wiki/Reconstruction:Proto-Indo-European/werd%CA%B0h%E2%82%81om#Proto-Indo-European says: 
   * From {{m|ine-pro|\*werh₁-|t=to speak, say}}, with the extension {{m|ine-pro||\*-dʰh₁-o-}} (from {{m|ine-pro|\*dʰeh₁-|t=to put}}), which expresses the perfective aspect. 
   * radix doesn't get that \*werdʰh₁om comes from \*dʰeh₁-





allow viewing the full tree without pruning; and without sense pruning.




