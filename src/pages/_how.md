

This page will leave a lot out. I can write a more thorough and detailed explanation if there's enough interest expressed. 

## Synopsis

Wiktionary has a bunch of articles on a bunch of words. We get the xml for these articles, and then process the xml to figure out which words link to which other words. That gives us a big directed graph, where an edge V→W means "we've guessed that W is an etymonic descendant of V". Then, spiritually speaking, given a word W, we traverse this digraph backward, i.e. pastward, taking the closure. That gives us all the words pastward of W. And then we take the transitive closure forward, i.e. futureward, which gives us all the words that are futureward of any word that's pastward of W, i.e. all the cognates of W in a cognate ~~tree~~ ~~poset~~ preorder. (We'll call it a poset.)

But. Here a "word" is a string of characters and a language. So homographs will collide; any cognate of W will also be considered a cognate of W's homograph W, even if W and W actually have different etymologies. So we do some tricks to guess at a subposet of W's cognate word poset, where we delete senses that we have reason to believe aren't related to W. 

Now we have our best guess at W's cognate poset. It's often still quite large--containing 10s or 100s of thousands of nodes. So we aggressively prune / restrict / compress / hide. Then we put it in a tree format to display.

## Getting wiktionary 

Twice a month, wiktionary makes xml dumps of all the articles on the site. We get these from 
[dumps.wikimedia.org/enwiktionary/](https://dumps.wikimedia.org/enwiktionary/), going for the one that looks like "enwiktionary-20240501-pages-articles.xml.bz2" but with a recent date. 


## Redirects

Omitted. 

## Breaking into articles

Omitted. 

## Parsing articles

Omitted lol. Something something alternating sequence of tokens alternating between text and parsed templates.

## Interpreting wiktionary templates

The etymology section of a wiktionary article for a word W says what words W comes from. This is rendered for easy reading, but under the hood it's written in markup. For example, the Etymology 1 section of the ["weave" article](https://en.wiktionary.org/wiki/weave) reads, in rendered text:

> From Middle English weven (“to weave”), from Old English wefan (“to weave”), from Proto-West Germanic \*weban, from Proto-Germanic \*webaną, from Proto-Indo-European \*webʰ- (“to weave, braid”).

On the page in the top right you can click the Edit button to see the [edit page](https://en.wiktionary.org/w/index.php?title=weave&action=edit) for that article. The corresponding markup: 

> From {{inh|en|enm|weven|t=to weave|id=to weave}}, from {{inh|en|ang|wefan||to weave}}, from {{inh|en|gmw-pro|\*weban}}, from {{inh|en|gem-pro|\*webaną}}, from {{der|en|ine-pro|\*webʰ-||to weave, braid}}.

WTF? Ok so {{inh|en|enm|weven|t=to weave|id=to weave}} means: 

* {{          --- here comes a [template](https://en.wiktionary.org/wiki/Wiktionary:Templates)
* inh         --- the word of this article is inherited from the following word/s
* en          --- the word of this article is an English word (see [language codes](https://en.wiktionary.org/wiki/Wiktionary:List_of_languages))
* enm         --- the word being inherited from is a Middle English word
* weven       --- the text of the word being inherited from is "weven"
* t=to weave  --- the translation of the word being inherited from is "to weave"
* id=to weave --- the specific sense of the word being inherited from is the one with the id "to weave"
* }}          --- end of template

In general we find info about templates at pages like [en.wiktionary.org/wiki/Template:inherited](https://en.wiktionary.org/wiki/Template:inherited). 

There lots of templates. Lots of them are irrelevant for our purposes, e.g. quotations, IPA, etc. The ones we care about are the one that describe ancestry and descent of words from other words. Some of the main etymological templates are [inherited](https://en.wiktionary.org/wiki/Template:inherited), [derived](https://en.wiktionary.org/wiki/Template:derived), [descendant](https://en.wiktionary.org/wiki/Template:descendant), and [descendant](https://en.wiktionary.org/wiki/Template:descendant) (which is a futureward link that shows up in the Descendants section of some articles). A haphazard somewhat fuller list: root, derived, inherited, inflection of, borrowed,suffix, prefix, affix, compound, univerbation, blend, confix, de-adj form of, plural of, verb form of, participle of, back-formation. 

So when we see one of these links, we register it. E.g., we store something like "(weave, English) links pastward to (weven, Middle English)". 

## Inferring more links

Just going by the links in "weave" Etymology 1, we get links pastward from weave. But there's a lot more information here. For example, here:

> From Middle English weven (“to weave”), from Old English wefan (“to weave”)...

This doesn't only say that (weave, English) comes both from (weven, Middle English) and from (wefan, Old English). It *also* says: (weven, Middle English) comes from (wefan, Old English). 

Recognizing this with a regex is prohibitively expensive. Unless you have the article in the form of sequences of tokens, in which case you can use abstract regular expressions, where the primitives can be any predicate on the base objects. Google truly is the best programming language: one Ruminat has already written [such a thing](https://github.com/Ruminat/Asq-Server/blob/master/modules/AbstractRegularExpressions.py). So we write a giant regex that finds these patterns, and we extract the links. 


## traversing

efficiency
connectivity

Wiktionary has a bunch of articles on a bunch of words. We get the xml for these articles, and then process the xml to figure out which words link to which other words. That gives us a big directed graph, where an edge V⟶W means "we've guessed that W is an etymonic descendant of V". We then take the transitive closure of this digragh to get a preorder, which tells us, for each word W, what are the words that are *immediately* futureward/pastward of W, and what are *all* the words that are pastward of W, 


