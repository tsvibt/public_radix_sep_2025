radix by tsvibt

BRIEF update 28 Sep 2025: this codebase is almost certainly in a BROKEN state; i got stuck trying to multi-process-ify it. it's probably not too far from kinda-working, but it is messily halfway through a big change. sorry. hopefully at some point i will rehydrate it. if you're really really motivated to work on it, reach out (gmail: radixtsvibt) and we can have a call, ideally recorded to post on my youtube channel-- to talk through installation, and generally how the code works.

updated 16 Jun 2024, but, probably incomplete. if you are interested in working on this, contact me (gmail: radixtsvibt) for help with setup.


broadly speaking, setting up a working radix goes like:

0. setting up the code
1. config
2. getting the wiktionary dump
3. running the "precomputing" code to build the (large; roughly 40GB) sql database
4. running the server
5. going to localhost/

to get set up, you should first use 40k-initial.xml, which is the first 40k lines of some older wiktionary dump. the precomputation takes order of a day for the full db, but a few minutes witk 40k-initial. should be included in the repo in radix/wiktionaries/.

step -1:
clone the radix repo.
(note: don't have the string "radix" in the path before the root of the repo... so don't make a directory "test_radix" and then clone radix there, because radix will interpret its home as test_radix/ rather than what it should be, test_radix/radix/)

step 0:
using python, and various modules that you'll have to install

there is one annoying thing to do, which involves lua. first install lupa (lua python) somehow. https://pypi.org/project/lupa/
pip3 install lupa
then in lua directory, eg /usr/local/lib/lua/5.4, make a dir:
mkdir ustring
and copy contents of radix/resources/LUA_USTRING there.

i don't remember what this is (i probably never knew) but i think it's important. it's some component that wiktionary uses, and radix uses a piece of wiktionary code which uses this ustring thing. very janky, should be fixed at some point :/
would at least be nice to have this be done automatically (by exporting an env variable that tells lua to look in radix/resources/LUA_USTRING/ , or something?)

step 1. 
make a file radix/src/config.py
and put this in there:

```
# controls roughly how much ram the precompute uses. probably necessary if you're going to run the precompute on the whole wikt db. value should be [number of MB of RAM of your computer - 10000] or something like that, e.g. for 32GB RAM:
G_RAM_ceiling = 15000

# to start with, to get the thing running at all:
WiktionaryXMLfile = "40k-initial.xml"

# for when you're using a full dump:
#WiktionaryXMLfile = "file_name_of_full_wiktionary_dump.xml"

```

step 2.
[omit if you're doing the 40k thing]
get from https://dumps.wikimedia.org/enwiktionary/
eg 
https://dumps.wikimedia.org/enwiktionary/20240601/
click on 
enwiktionary-20240601-pages-articles.xml.bz2
then uncompress and move to radix/wiktionaries/

step3
make sure that the text in 
src/precomputing/run_all.py
has all the things included in x
currently it goes from 
A_xmldump_redirects
to
P_O_pastmostsense_futuresenseposet
(not necessarily in order /with every letter)

then from directory 
radix/
run 
python src/precomputing/run_all.py


fix errors by installing python packages. if that doesn't work contact me lol. 
should take <10 min for 40k.

step 4
from directory
radix/
run
python src/page/server.py

step  5 
go to 
localhost/
in a browser
or  try 
localhost/dictionary
localhost/pond
localhost/elephant
(most words will not work as they don't show up in 40k)





