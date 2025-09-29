'''
python src/precomputing/run_all.py
python src/site/server.py 
python src/tests.py previous /Users/tbt/radix/wiktionaries/mill-initial/mill-initial-24.09.13-03_35_11.db
python src/tests.py previous /Users/tbt/radix/wiktionaries/mill-initial/Checkpoint_mill-initial.db
python src/tests.py test  
python src/tests.py fulltest
python src/tests.py FULLRESET
'''

from src.radix import *

from itertools import combinations
import difflib
import subprocess


TEST_WORDS = [str_Word(line) for line in """
[Steige, de]_0
[swinesties, en]_0
[pigstye, en]_0
[stirrups, en]_0
[stirrupless, en]_0
[stirruplike, en]_0
[stirruped, en]_0
[stewardess, en]_0
[under-steward, en]_0
[stewardish, en]_0
""".split('\n') if line.strip() != '']


def test_word_ordering():
   TEST_WORDS.sort()
   for word in TEST_WORDS:
      assert str_Word(word.__repr__()) == word
      assert word == word, "not equal to self"
      assert word <= word, "not <= to self"
      assert word >= word, "not >= to self"
      assert not word != word
      assert not word < word
      assert not word > word
   for word1, word2 in combinations(TEST_WORDS, 2):
      assert word1 != word2
      assert not word1 == word2
      assert word1 < word2 or word1 > word2
      assert not (word1 < word2 and word1 > word2)

#test_word_ordering()

def Table_AssertTweakEqual(table):
   return AssertTablesEqual(table, globals()[table.name+'OLD'])

def AssertTablesEqual(table1, table2):
   table1.ALLCACHE(to_print=False)
   table2.ALLCACHE(to_print=False)
   print('')
   print(f'loaded tables: {table1.name} and {table2.name}')
   obj1 = GLOBALCACHES[table1.name_of_cacheget] 
   obj2 = GLOBALCACHES[table2.name_of_cacheget] 
   comparison = obj1 == obj2
   print(f'{str(comparison).upper()} that the two tables {table1.name} and {table2.name} are equal')
   print('')
   return (obj1, obj2, comparison)


##### stored tests

def Tests_handle(actions):
   match actions:

      case ['test']                     : Run_sql_tests()
      case ['reset']                    : ResetTests(ComputeTests())
      case ['previous', prev_db]        : previousDB_compare(prev_db)
      case ['checkpoint_test']          : previousDB_compare(Wiktionary.checkpoint_db_dir)
      case ['checkpoint_test', *tables] : previousDB_compare(Wiktionary.checkpoint_db_dir, given_tables=tables)
      case ['onetest', file]           : __X__OneTest(file)
#      case ['onetest', file, *tables]  : __X__OneTest(file, *tables)
      case ['fulltest']                 : __X__FullTest()
      case ['FULLRESET']                : __X__FullReset()
      case ['runall']                   : __X__RunAll()
      case other                        : print(f'\nno such command: {other}\n')



def Run_sql_tests():
   print('')
   print('TESTING...')
   tests_cached = {} if DB._Tests.Count() == 0 else ({} if not (one_value := DB._Tests.OneValue()) else one_value)
   tests_computed = ComputeTests()
   #   maybe do all tests, show which failed?
   for key in sorted(tests_cached.keys() & tests_computed.keys()):
      assert tests_cached[key] == tests_computed[key], print('\n\nFAILED key', key, '; diff:', 
                                                         test_strings_compare(tests_cached[key], tests_computed[key]))
      print('passed test', key)
   print('\n')
   print('ALL TESTS PASSED')
   del_keys = tests_cached.keys()   - tests_computed.keys()
   new_keys = tests_computed.keys() - tests_cached.keys()
   if del_keys: print(f'WARNING: deleting test keys {del_keys}')
   if new_keys: print(f'NOTE: adding test keys {new_keys}')
   ResetTests(tests_computed)


def ComputeTests():
   import src.printing.printing as p
   result = {}
   for text in ['dictionary', 'elephant', 'pond', 'sing', 'free', 'abstract', 'drag', 'thing', 'hammer', 'care', 'coalesce', 'confer','weave', 'platypus', 'cling', 'water', 'big', 'warp', 'gram']:
      for word in (gram := Gram(text, 'en')).GivensOrPlaceholder() | {Word(gram, 1)}:
         ID_maker.maybe_reset(0)
#         result[f'initial {word}'] = Word_CognatesHTMLContent(word)
         result[f'initial {word}'] = p.Word_CognatesHTML(word)
         result[f'async {word}'] = p.WordCoglangs_AsyncHTMLContent(word, G_Default_Coglangs, new_id_count=0)

         if (poset := word.PastwardWordposet()):
            for future_gram, past_grams in poset.immediate_ulteriors.items():
               for past_gram in past_grams:
                  if (key := f'inspection {future_gram} pastward to {past_gram}') not in result:
                     result[key] = p.Info_Inspection({'gram':past_gram, 'clusion_wordnums':
                                     {'included':[past_word.num for past_word in poset.includedWords[past_gram]],'excluded':[]}, 
                                     'parent': {'gram':future_gram, 'direction': 'both'}}, new_id_count=0)

   for page_name in p.G_page_names: 
      result[f'page {page_name}'] = p.pagename_html('_' + page_name)
#      try    : result[f'page {page_name}'] = pagename_html('_' + page_name)
#      except : pass # eg _output.md fails--on a subuniverse--because it has PASTWARD "dictionary", but whatever.

   return result

def ResetTests(new_tests):
   print('resetting tests...')
   DB._Tests.Drop()
   DB._Tests.InsertRow([new_tests])
   print('tests reset.')

def previousDB_compare(prev_db_dir, given_tables=None):
   if given_tables is None: test_word_ordering()
   previous_DB = Disk_DB(prev_db_dir)
   print(f'''comparing current database {DB.stem}, \nfile {DB.directory} to previous database {previous_DB.stem}, \nfile {previous_DB.directory}''')
   skipped, succeeded, failed = Aggregator(divider=', '), Aggregator(divider=', '), Aggregator(divider=', ')
   check_tables = given_tables or DB.real_table_names()
   print('\ncurrent db tables:', check_tables)
   print('\ncheckpoint db tables:', previous_DB.real_table_names())
   for table_name in check_tables:
      if table_name not in previous_DB.real_table_names():
         skipped << table_name
      else:
         table = getattr(DB, table_name)
         prev_table = getattr(previous_DB, table_name)
         cache_dict1, cache_dict2, comparison = AssertTablesEqual(table, prev_table)

         if comparison : succeeded << table_name
         elif len(cache_dict1) == 0 or len(cache_dict2) == 0:
            print(f'\n\nSKIPPING table {table_name}\n')
            skipped << table_name
#            break why break here? something to do with single table testing... but this messes with adding a new table
         else:
            failed << table_name
            print(f'\n\nFAILED table {table_name}\n')
            obj_diff(cache_dict1,cache_dict2)
            print('\n\n')

   print(f'''\ncompared current database (first) to previous database (second):\nfile {DB.directory}\nfile {previous_DB.directory}''')
   if failed():
      print(f"\n\nFAILED tables [{failed()}]\n\n")
   else:
      print('\nPASSED all ran comparisons')
      print(f"\nsucceeded with tables [{succeeded()}]\n")
      previous_tables = ', '.join([name for name in previous_DB.real_table_names() if name not in DB.real_table_names()])
      if skipped() or previous_tables:
         print(f"SKIPPED tables [{skipped()}] from db {DB.stem} because they're not in the previous db {previous_DB.stem}")
         print(f"SKIPPED tables [{previous_tables}] from db {previous_DB.stem} because they're not in the current db {DB.stem}")
      else:
         print('ALL tables SUCCEEDED, none skipped')
      print('\n')
      if succeeded() == '': print(f"WARNING WARNING WARNING: succeeded, but with no tables!")


def __X__RunAll():
   command = """python src/precomputing/run_all.py """
   result = subprocess.run(command, shell=True, check=True)
   Wiktionary._SET_(WiktionaryContext(WiktionaryXMLfile))
   Run_sql_tests()
#   try: Run_sql_tests()
#   except: print('!! Run_sql_tests FAILED !!')

def __X__FullTest():
   __X__RunAll()
   command = f"""python src/tests.py checkpoint_test"""
   result = subprocess.run(command, shell=True, check=True)

def __X__OneTest(file):
#def __X__OneTest(file, *tables):
   command = f"""python src/precomputing/{file.split('/')[-1]}"""
   result = subprocess.run(command, shell=True, check=True)
   tables = [x.split('.')[-1] for x in Read(file).split('target tables')[1].split('[')[1].split(']')[0].split(',')]
   command = f"""python src/tests.py checkpoint_test {' '.join(tables)}"""
   result = subprocess.run(command, shell=True, check=True)

def __X__FullReset():
   if WiktionaryXMLfile not in ["40k-initial.xml", "mill-initial.xml"] and not File_isSubuniverse(WiktionaryXMLfile): return 
   __X__RunAll()
   new_db_dir = Wiktionary.most_recent_databases_directory()
   command = f"""cp -r {new_db_dir} {Wiktionary.checkpoint_db_dir}"""
   result = subprocess.run(command, shell=True, check=True)
   print(f"created new db {new_db_dir} for xml file {WiktionaryXMLfile} and copied to checkpoint {Wiktionary.checkpoint_db_dir}")


if len(sys.argv) > 1: Tests_handle(sys.argv[1:])




