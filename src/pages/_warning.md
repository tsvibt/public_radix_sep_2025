


STL yellow;background-color:rgb(120, 40, 40);
Many results from radix will be BX *! INCORRECT !* BX, confusing, misleading, or incomplete. 
STL 

STL red;
You should quasi-verify results by clicking around the wiktionary pages and reading etymology sections. Radix is a good tool for *discovery* of *plausible* cognates, but unfortunately is not yet very close to being clear and reliable. 
STL 


See å_outputå and å_visionå to understand what the output is *supposed* to be.

## Alpha disclaimer

STL rgb(225, 150, 40);

If you're reading this, you're interacting with an alpha version of radix. That means:


* Things might break, e.g. the website might go down or some pages might not work.
* Things might suck, e.g. be unfinished or have a messed up UI, or the server might be really slow.
* Things might change, e.g. the output format/styling or url format might change.
* Features might come and go. 
* The quality of the output might be notably worse than it will be later.
* The server might not be secure.

STL


## Kinds of error 

Here are ways that the radix page for word W (more precisely, for one sense of W) can be wrong. 


| In many cases, the page will have a: | Which means that the page: | 
| --- | --- |
| STL lightgreen; False cognate STL | shows another word V in a list of cognates of W and/or in a pastward or futureward cognate poset of W, when in reality V is not a cognate of W. |
| STL lightgreen; Missing cognate STL | fails to list a true cognate V. |
| STL lightgreen; Misleading sense STL | correctly shows a word V as a cognate because V has a sense S that's cognate with W, but S is a surprising, uncommon, or obscure sense of V that is homographic with a more common sense Z of V that is *not* cognate with W, and this is not made clear.|
| STL lightgreen; False sense STL | correctly lists a cognate V, but includes senses of V that are not cognate with W. |
| STL lightgreen; Missing sense STL | correctly lists a cognate V, but fails to include the sense of V that is cognate with W. |
| STL lightgreen; Overconfident cognate STL | shows a word V that is only possibly, plausibly, perhaps cognate with W.|
| STL lightgreen; Non-existent word STL | shows a word V that is not actually a word, e.g. it is misspelled or contains markup or punctuation.|
| STL lightgreen; False descent STL | shows V as descending from another word U, when in reality V does not descend from U.|
| STL lightgreen; Missing descent STL | fails to show V as descending immediately from U, when in reality U is a most recent ancestor of V.|



## Sources of error 

### Radix

This is a partial list of ways that radix introduces errors. (See å_futureå for more discussion.)

| | |
| --- | --- |
| In general, STL lightgreen; missing features of how wiktionary works STL | For a long time ~~radix~~ I did not know about [redirections](https://en.wiktionary.org/wiki/Wiktionary:Redirections); there may be other such features. |
| In general, STL lightgreen; making assumptions about how wiktionary works STL | For example, radix assumes that all articles in the wiktionary xml dumps are contained in <page\> tags and have a title in <title\> tags, which is probably true, but there are lots of assumptions like this, each of which could be false.|
| STL lightgreen; Misparsing articles STL | E.g. not handling ===, {{, }}, and \| correctly, especially nested like {{\|{{\|}}\|}}. |
| STL lightgreen; Omitting or misinterpreting headers STL | There are a bunch of [headers](https://en.wiktionary.org/wiki/Wiktionary:Entry_layout) in wiktionary articles. Radix doesn't know about all of them, and might misinterpret them.|
| STL lightgreen; Mispartitioning headers into senses STL | There's no strict layout in wiktionary articles, and in particular it's not always determined how to partition subsections of one language's article into sections that discuss senses of the word which all share a single etymology.|
| STL lightgreen; Omitting or misinterpreting templates STL | There are many wiktionary [templates](https://en.wiktionary.org/wiki/Wiktionary:Templates)--markup sections that, among other things, crucially specify etymological links between words. Many templates are discarded by radix, and might be misparsed. |
| STL lightgreen; Failing to parse out word texts STL | Wiktionary has some way of formatting the texts of words in templates using [[]] and stuff, which I don't understand and which therefore sometimes produces garbage in radix results | 
| STL lightgreen; Applying the wrong text transformation to word texts STL | The texts of words in wiktionary templates are written to be displayed, which is often not identical to the text of the word in the wiktionary article for that word (e.g. a word displays with diacritics, but some of the diacritics are absent in the article title). The makeEntryName function and other code does this translation in wiktionary (see [en.wiktionary.org/wiki/Module:languages](https://en.wiktionary.org/wiki/Module:languages)), but I don't know how to plug the actual code into radix. So radix uses a janky old partial version of that code, which is okayish but probably incorrect. | 
| STL lightgreen; Incorrectly inferring etymological links STL | Some links between words are straightforward, e.g. the [inherited template](https://en.wiktionary.org/wiki/Template:inherited). But radix goes further and uses abstract regexs to infer more links, e.g. saying that W comes from V if some other article says in its etymology section "... W, from V, ...". This works somewhat well, but sometimes falsely infers links. |
| STL lightgreen; Incorrectly in- or ex-cluding senses STL | If a word has multiple senses, radix uses a few heuristics to guess which senses are and are not really cognate with the present word. The heuristics are far from perfect. |

<br>
There's a lot of code in radix that isn't touched on in the above table, and of course any of that code could have bugs that introduce more errors. E.g. the order handling (transitive closure, etc.), handling language code aliases, pruning posets for display, traversing posets for display, etc. 


### Other sources
the etymologies themselves are in their heart of hearts confusing. eg "influenced by". eg heathen 

root of heathen:
https://en.wiktionary.org/wiki/h%C3%A6%C3%BEen

https://en.wiktionary.org/wiki/duffle


we don't know the etymologies; they're lost to time, or we havent' studied them yet
theres disagreement and uncertainty
the etymologoise haven't been copied into wiktionary
wiktionary has typos
radix fails to use the info in wiktionary  correctly
gap between






