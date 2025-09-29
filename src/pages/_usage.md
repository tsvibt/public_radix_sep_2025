
This page says how to interact with radix.

If you're wondering about the results that radix displays, see å_outputå.

If you're wondering about what the results are supposed to be, see å_whyå and å_futureå.

This might become outdated. Last checked June 2024.


## Basic entry point

The basic way to start using radix is to go to a url of the form radix.ink/x, where x is an English word, e.g. åwishå. This redirects you to a url of the form radix.ink/word/lang:en/x, e.g. åword/lang:en/wishå.

At that url, you see the radix report on the English word "wish". 

## Navigation

### Link buttons meanings

These are links to other pages associated with a word.

@@Wiktionary button@@ The wiktionary article for this word. 

@@Etymonline button@@ The Etymonline article for this word.

@@Radix button@@ The radix page for this word. 

(For some words, these pages don't exist.)


### Link button usage details

BX Cmd-click on a word BX: open the wiktionary page for that word in a new window, but stay in this window. (Wiktionary might not have a page for that word.)

BX Hover over a word BX: a popup appears with navigation buttons for that word. BX Mouse-off or click-off or press Escape key BX: the popup disappears. 

BX Click on a word BX: a popup appears with navigation buttons and a bunch of information. BX Mouse-off BX: the popup stays. BX Click-off or press Escape key BX: the popup disappears. 

Navigation buttons: BX Click BX: open link in new tab and focus on that tab. BX Cmd+click BX: open link in new tab (but don't change focus). BX Shift+click BX: open link in current tab.

### Jumping

(Note: This is NOT implemented at the moment.)

A little jump button @@jump button@@ appears next to a word displayed in an etymology poset if the same word has already been displayed in that poset. This occurs if the poset isn't a tree (see å_outputå).

Clicking on the jump button will move the screen so that the first occurrence of the word in the same etymology poset is visible. The first occurence will briefly flash white. (Moving the screen is rarely needed in the pastward poset, but sometimes needed in the futureward poset, as it's much bigger.) 

In the section that lists cognates, the jump button <button class="jump-button-without-symbol link-button "></button> plays a similar role. It appears in the popup for a word, and it jumps down to the first occurrence of that word in the futureward poset. 


## More entry points

The reliable to way to figure out how to specify an entry point is to start somewhere, and then navigate within radix, and then look at the url to see the format. Eventually radix might provide search tools. Currently:

In general you can go to a url of the form radix.ink/word/Y/X, where X is a word in some language L, and Y is an options string which specifies L and maybe specifies more information. An options string Y specifies a language by starting with 'lang:L'. For example, åword/lang:de/Wunschå.

L is a two- or three-letter language code. Language codes are listed [here](en.wiktionary.org/wiki/Wiktionary:List_of_languages). Eventually radix might accept plain names for languages, or try to guess the language based on just the word's text. Some language codes: English is en; German is de; Latin is la; Ancient Greek is grc; PIE is ine-pro.

It is also possible to specify the sense number. If there are multiple etymologies for one word (e.g. åweaveå), radix will automatically assume you mean the first one. But you can specify another one, like so: åword/lang:en&sensenum:2/weaveå













