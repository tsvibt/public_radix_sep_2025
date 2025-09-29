


## What is radix?

It's a cognate-tree-grower. 

<br>
In other words:

People speak and think with words. Words come from older words. Those older words come from even older words. People figured out which words came from which other words. They wrote that down in big books. Other people looked at what is in those big books and wrote it all together into [wiktionary.org](https://www.wiktionary.org/). If you ask radix about a word, radix looks at what is in [wiktionary.org](https://www.wiktionary.org/) and tells you what older words that word came from, and then tells you what younger words came from those older words. 

## Why?

The simple answer is that it seems like a canonical sort of tool to have. The cognate tree of a word is a natural object to be interested in. Separately, the guts of radix might be useful for other sorts of analytics; see å_futureå.

<br>
A more personal answer:

A word is a little poem, an elemental nexus of metaphors and threads of living. A cognate tree shows the little poem, which is almost just a single word but has many branches: the different possibilities for that urword. 

Examples make abstract ideas live; etymons make words live.

## Huh?

Knowing the etymology of a word is a bit like reading the code that defines a function in a computer program. Usually just reading the code of that one function is far from fully explaining everything about that function. If the code calls other functions, you'd have to read their code too; you might not understand how the code works, even after reading it once; there are important things hidden from sight even if you read the whole codebase, e.g. whatever the compiler does behind the scenes with the code; and you don't know the context that the code works in, e.g. where the inputs come from and what they mean, and where the function is called from and what its outputs mean. But even so, you're taking a few steps in understanding what's going on. It's hard to encompass those steps as a discrete product, as if you had to have gotten noticeably better at a predemarcated task--no, you just... understood a little more, and then a little more...

<br>
Some things you can do with radix:

* Given a word, understand its [morpheme](https://en.wikipedia.org/wiki/Morpheme)(s)/[sememe](https://en.wikipedia.org/wiki/Sememe)(s), and understand what other words those elements have given rise to. 
* Given a new word you don't know (whether in a language you do or don't know), see words that share an etymon with that word. If you know some of those cognates, it gives you a sense of what the new word means, and maybe makes it easier to remember the new word even if it's somewhat [semantically opaque](https://en.wikipedia.org/wiki/Transparency_(linguistic)#Descriptive). 
* See how to use the word better--get a more vivid and memorable sense of the word's meaning, so you more readily recognize where it's suitable, and so you have more sense of where it's not quite the right shade of meaning. 
* Potentially, see how better to [make new words](https://tsvibt.blogspot.com/2023/05/the-possible-shared-craft-of-deliberate.html) by combining morphemes/sememes, from seeing how those morphemes have previously been combined to make words. 

## Why not just use wiktionary?

Wiktionary is good and is better than radix for some purposes, e.g. if you want to get more detailed info about one word such as pronunciation, quotes, definitions, etc. Also, you can click around on wiktionary to traverse the cognate tree. But:

* It takes some work, clicking around and waiting for pages to load.
* It takes some work, parsing the etymology sections, especially when a Proto-Indo-European root lists 50 descendants in a dozen proto-languages, but you're only looking for, say, descendants in modern languages you're familiar with.
* In some cases, wiktionary's link graph contains one-way edges. That is, wiktionary's entry for word X might say "my root is Z", but then entry for Z doesn't say "one of my descendants is X", even via intermediates. So if you start at Y, which also says "my root is Z", then you get to Z but you don't realize that X is a cognate of Y, because X isn't linked by Y or Z. Thus naive traversal is incomplete.
* You don't build up a panorama, except in your head. 

Radix largely solves these problems.

## What about Etymonline?

It's a beautiful website. But:

* It is focused solely on English and to some extent its ancestors. 
* It uses a nonstandard way of rendering Proto-Indo-European. 
* Wiktionary (and therefore radix) tends to have more information even about English, though not in all cases.
* Although it often provides useful lists of cognates (doublets, that is), like wiktionary it doesn't provide a panoramic cognate tree.

## Has this already been done?

No. There have been a number of projects that are similar in concept, but none are adequate, at least for my purposes. See for example [etytree](https://etytree.toolforge.org/).

