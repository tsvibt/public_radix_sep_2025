'''
scalene src/precomputing/T_gramorder_sortkey.py
'''

from src.precomputing.coordinator import *

EnglishGramsOrdered = Read(f'{RadixRootdir}resources/grams_by_frequency.txt').split('\n')

to_do_1 = OBJECT_TABLE_TODO({word:i for i,word in enumerate(EnglishGramsOrdered[:300_000])}, 
                               DB._EnglishGramtext_Sortkey, dict_single_value=True)

CALL([to_do_1, ])



