
"""
exec(open('resources/scraping/scrape_wiki_word_frequencies.py').read())
"""

# currently using this, stored in grams_with_counts.txt:
# https://github.com/IlyaSemenov/wikipedia-word-frequency/blob/master/results/enwiki-2023-04-13.txt
# maybe a better one here, idk: https://en.wiktionary.org/wiki/Wiktionary:Frequency_lists/English

import os 

RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'
freq_file = RadixRootdir + 'resources/grams_with_counts.txt'
text = '\n'.join(line.split(' ')[0] for line in open(freq_file,'r').read().split('\n'))
open(RadixRootdir + 'resources/words_by_frequency.txt','w').write(text)


