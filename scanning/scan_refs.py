"""
exec(open('src/scanning/scan_refs.py').read())
"""
exec(open('src/precomputing/abstracted.py').read())

def FUN(word_exploring, direction, givens):
   for given in givens:
      if word_exploring not in SQL_WORD_Direction_GivenRefWords_CACHE_Select(given, Direction_Reversed(direction)):
         print(word_exploring, direction, givens)
   return []

to_do_1 = {'generator source':SQL_WORD_Direction_GivenRefWords, 'function':FUN, 'target tables':[SQL_SANDBOX], 'message': '', 'printing': False}

CALL([to_do_1, ], to_profile=False)




