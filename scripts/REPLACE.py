'''
python scripts/REPLACE.py
'''

import os

def replace_string_in_files(directory, s1, s2):
   for root, _, files in os.walk(directory):
      for file in files:
         filepath = os.path.join(root, file)
         if (not file.split('.')[-1] in {'py'}) or any(x in filepath for x in ['backups-nvim', '__pycache__', 'DS_Store', 'page/']):
            print('skipping', file)
         else:
            print('replacing in', file)
            with open(filepath, 'r') as f:
               content = f.read()
            content = content.replace(s1, s2)
            with open(filepath, 'w') as f:
               f.write(content)

replacements = [
]


for s1,s2 in replacements:
   replace_string_in_files('./', s1, s2)


"""
replace_string_in_files('./', '', '')
file.endswith('sql.py') or 

py
('_GRAM_StrictPastwardset', '_GRAM_StrictPastwards'),

in .py
('.gram.lang', '.lang'),
('.gram.text', '.text'),

in .py
('reference', 'template'),
in .py
('_WORD_FutureGramlinks','_WORD_OwnFuturewardGramlinks'),
('_WORD_Direction_Gramrefs', '_WORD_Direction_OwnRefGrams'),
('_GRAM_Strictpastwards', '__GRAM_StrictPastwards'), # lol wut
('_GRAM_ImmediatePastwardset','_GRAM_ImmediatePastwards'),
('_GRAM_ImmediateFuturewardset','_GRAM_ImmediateFuturewards'),
('_GRAM_Strictfuturewardset','_GRAM_StrictFuturewards'),
('_GRAM_Coglang_Langstrictfutures','_GRAM_Coglang_LangStrictFutures'),
('_WORD_Pastwardwordposet','_WORD_PastwardPoset'),
('_AllPastmostwords','_AllPastmostWords'),
('_WORD_Lang_Futurewordposet','_WORD_Lang_FuturewardPoset'),

in .py
('Select', 'Get'),

in .py, .html
('sense', 'word'),
('Sense', 'Word'),
('SENSE', 'WORD'),

in .py, .html
('word', 'gram'),
('Word', 'Gram'),
('WORD', 'GRAM'),


('SQL_', 'DB._')
('_CACHE_Select', '.CACHE_Select')

('Wordtext_Lang_Allpastwards', 'WORD_Allpastwards'),
('Wordtext_Lang_Pastmosts', 'WORD_Pastmosts'),
('Wordtext_Lang_FuturePoset', 'WORD_FuturePoset'),
('Wordtext_Lang_RealGivenSenses', 'WORD_RealGivenSenses'),
('Wordtext_Lang_Direction_Coveringsenses', 'WORD_Direction_Coveringsenses'),
('Wordtext_Lang_Strictfutureset', 'WORD_Strictfutureset'),
('Wordtext_Lang_Coglang_Langfutures', 'WORD_Coglang_Langfutures'),
('Wordtext_Lang_Sensenum_Pastwardsenseposet', 'SENSE_Pastwardsenseposet'),
('Wordtext_Lang_Sensenum_Lang_Futuresenseposet', 'SENSE_Lang_Futuresenseposet'),
('Wordtext_Lang_Sensenum_HTMLs', 'SENSE_HTMLs'),

[
('Wordtext_Lang_Allpastwards', 'WORD_Allpastwards'),
('Wordtext_Lang_Pastmosts', 'WORD_Pastmosts'),
('Wordtext_Lang_FuturePoset', 'WORD_FuturePoset'),
('Wordtext_Lang_RealGivenSenses', 'WORD_RealGivenSenses'),
('Wordtext_Lang_Direction_Coveringsenses', 'WORD_Direction_Coveringsenses'),
('Wordtext_Lang_Strictfutureset', 'WORD_Strictfutureset'),
('Wordtext_Lang_Coglang_Langfutures', 'WORD_Coglang_Langfutures'),
('Wordtext_Lang_Sensenum_Pastwardsenseposet', 'SENSE_Pastwardsenseposet'),
('Wordtext_Lang_Sensenum_Lang_Futuresenseposet', 'SENSE_Lang_Futuresenseposet'),
('Wordtext_Lang_Sensenum_HTMLs', 'SENSE_HTMLs'),
]

"""



