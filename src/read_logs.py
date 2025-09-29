'''
python src/tests.py fulltest
python src/read_logs.py history 40k-initial _GRAM_RealGivenWords
python src/read_logs.py history 40k-initial _WORD_PastwardPoset
python src/read_logs.py history mill-initial _GRAM_RealGivenWords
python src/read_logs.py history mill-initial _WORD_PastwardPoset

python src/read_logs.py history mill-initial _WORD_PastwardPoset execute
python src/read_logs.py history mill-initial _WORD_PastwardPoset Get
python src/read_logs.py history mill-initial ANY Get
python src/read_logs.py history mill-initial ANY Unpickle
python src/read_logs.py history mill-initial ANY InsertRow
python src/read_logs.py history mill-initial ANY Pickle
python src/read_logs.py history mill-initial _GRAM_Coglang_LangStrictFutures Pickle
python src/read_logs.py history mill-initial _GRAM_Coglang_LangStrictFutures InsertRow
python src/read_logs.py history mill-initial _GRAM_Coglang_LangStrictFutures Compress
python src/read_logs.py history mill-initial _GRAM_Coglang_LangStrictFutures execute
python src/read_logs.py history mill-initial ANY execute
python src/read_logs.py history mill-initial _WORD_PastwardPoset execute

python src/read_logs.py history mill-initial _WORD_PastwardPoset InsertRow

python src/read_logs.py history 40k-initial ANY  execute
python src/read_logs.py history 40k-initial _GRAM_Direction_Coveringwords execute
python src/read_logs.py history 40k-initial 
python src/read_logs.py history mill-initial 
python src/read_logs.py history_sum mill-initial execute
python src/read_logs.py history_sum mill-initial Get

python src/read_logs.py history 40k-initial _GRAM_StrictPastwards 

python src/read_logs.py history 40k-initial _GRAM_StrictPastwards execute
python src/read_logs.py history mill-initial _GRAM_StrictPastwards execute


python src/read_logs.py history 40k-initial _WORD_Lang_FuturewardPoset execute
python src/read_logs.py history 40k-initial _WORD_PastwardPoset execute
python src/read_logs.py history 40k-initial _WORD_PastwardPoset executemany

multiproc:
python src/read_logs.py history 40k-initial _WORD_OwnFuturewardGramlinks
python src/read_logs.py history mill-initial _WORD_OwnFuturewardGramlinks

python src/read_logs.py history 40k-initial _WORD_Lang_FuturewardPoset
python src/read_logs.py history mill-initial _WORD_Lang_FuturewardPoset

python src/read_logs.py history 40k-initial _GRAM_Direction_Coveringwords
python src/read_logs.py history mill-initial _GRAM_Direction_Coveringwords
python src/read_logs.py history mill-initial 
python src/read_logs.py history 40k-initial 

python src/read_logs.py history 40k-initial _GRAM_Parsed
python src/read_logs.py history mill-initial _GRAM_Parsed

python src/read_logs.py history 40k-initial _WORD_PastwardPoset


python src/read_logs.py history mill-initial _EnglishGramtext_Sortkey

python src/read_logs.py history 40k-initial _GRAM_AllMentioningGrams
python src/read_logs.py history mill-initial _GRAM_AllMentioningGrams


_GRAM_StrictPastwards
in theory, could speed up by caching the results from all but the most recent file.
first with executemany:
   Wed Oct  9 09:38:57 2024    /Users/tbt/radix/aux/cProfile_aux.stats
'''

from src.radix import *

def All_Reports():
   for file in Directory_Files(f'{LogDir}/precompute/'):
      for reporttext in Read(file).split('\ntargeting ')[1:]:
         yield reporttext

def line(n, text): return text.split('\n', n+1)[n]

def reporttext_wiktionary(reporttext): 
   if '/DBs/' in reporttext: return line(0, reporttext).split('/')[-2]
   else: return line(0, reporttext).split('/')[-1]
def reporttext_tables(reporttext):     return [x.strip() for x in line(0, reporttext).split('run on')[0].split(',')] + ['ANY']
def reporttext_date(reporttext):       return line(1, reporttext).split('/')[0]
def reporttext_time(reporttext):       return line(3, reporttext).split('seconds')[0].strip().split(' ')[-1]



def reporttext_function_time(reporttext, function):
   for line in reporttext.splitlines():
      if f"method '{function}'" in line or f"({function})" in line:
         return line

def reporttext_function_time_sections(reporttext, function): 
   if (timeline := reporttext_function_time(reporttext, function)):
      return list(filter(None, timeline.split(' ')))
   return [0,0,0,0,0,]

def reporttext_function_totaltime(reporttext, function): return reporttext_function_time_sections(reporttext, function)[1]
def reporttext_function_cumultime(reporttext, function): return reporttext_function_time_sections(reporttext, function)[3]

def wikistem_table_print(stem, table, function=None):
   if function: 
      print("                                          ncalls  tottime  percall  cumtime  percall filename:lineno(function)")
   for reporttext in All_Reports():
      if reporttext_wiktionary(reporttext).startswith(stem):
         if table in (tables := reporttext_tables(reporttext)):
            print(f"\n{reporttext_time(reporttext):<8} {reporttext_date(reporttext)}", end='')
            if function and (time := reporttext_function_time(reporttext, function)):
               print(time, tables[:-1], end='')
   print('')

def wikistem_print(stem):
   reports = [x for x in All_Reports() if reporttext_wiktionary(x).startswith(stem)]
   while len(reports)>0:
      first_wikt = reporttext_wiktionary(reports[0])
      this_chunk, reports = ListPredicate_ChompUntil(reports, lambda x: reporttext_wiktionary(x)!=first_wikt)
      print("{:.2f}".format(sum(float(reporttext_time(x)) for x in this_chunk)), first_wikt)


def wikistem_function_sumprint(stem, function):
   reports = [x for x in All_Reports() if reporttext_wiktionary(x).startswith(stem)]
   while len(reports)>0:
      first_wikt = reporttext_wiktionary(reports[0])
      this_chunk, reports = ListPredicate_ChompUntil(reports, lambda x: reporttext_wiktionary(x)!=first_wikt)
      print('total:', "{:.2f}".format(sum(float( reporttext_function_totaltime(x, function)) for x in this_chunk)), first_wikt)
      print('cumul:', "{:.2f}".format(sum(float( reporttext_function_cumultime(x, function)) for x in this_chunk)), first_wikt)

#reporttext_function_time(x, function)

def Logs_Handle(args):
   match args:
      case ['history', stem]:                  wikistem_print(stem)
      case ['history', stem, table]:           wikistem_table_print(stem, table)
      case ['history', stem, table, function]: wikistem_table_print(stem, table, function)
      case ['history_sum', stem, function]:    wikistem_function_sumprint(stem, function)


if len(sys.argv) > 1: Logs_Handle(sys.argv[1:])






