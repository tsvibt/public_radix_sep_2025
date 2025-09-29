from src.autoconfig import * 
from src.config import * 

from dataclasses import dataclass
import datetime
import cProfile
import pstats
from pstats import SortKey
import time
from pprint import pprint
from itertools import takewhile, product
import sys
from io import StringIO
import functools
import psutil
import multiprocessing
import re

def Read(file, read_type='r'):
   with open(file, read_type) as f: return f.read()

IDENTITY = lambda x: x

def Histogram_add(d, k): d[k] = 1 + d.get(k, 0)

def print_histogram(histogram, to_reverse=True):
   items = sorted(histogram.items(), key=lambda x:x[0])
   if to_reverse: items = reversed(items)
   [print(key,':',value) for key,value in items]

#https://realpython.com/primer-on-python-decorators/#simple-decorators-in-python
def REPORT(fun):
   @functools.wraps(fun)
   def wrapper_REPORT(*args, **kwargs):
#      argstring = ', '.join(arg for arg in args if type(arg) in [str, int])
      argstring = 'boop'
      mprint('call:', fun.__name__, '   on: ', argstring)
      result = fun(*args, **kwargs)
      mprint('done calling', fun.__name__, 'with short arguments', argstring)
   return wrapper_REPORT

class Caches(dict):
   def CACHIFY(self, function, name=None):
      function_name = name or function.__name__ 
      #print(f'making cache for function {function_name}')
      self[function_name] = {}
      @functools.wraps(function)
      def cachified(*args): # setdefault is NOT shortcircuiting
         if args not in self[function_name]: self[function_name][args] = function(*args)
         return self[function_name][args] 
      return cachified

   def wipe(self, keys)        : self.update({k:{} for k in keys & self.keys()})
   def wipe_all(self)          : self.wipe(self.keys())
   def wipe_except(self, keys) : self.wipe(self.keys() - keys)
   def ensure_below_ceiling(self): 
      if exceeding_RAM_ceiling():
         print('\n\nWIPING CACHES\n')
         for cache_name in ['DB._GRAM_Direction_Coveringwords_CACHE_Get', 'DB._GRAM_Direction_GivenRefGrams_CACHE_Get', 
                            'DB._GRAM_RealGivenWords_CACHE_Get', 'DB._WORD_OwnFuturewardGramlinks_CACHE_Get']:
            if exceeding_RAM_ceiling(): GLOBALCACHES.wipe({cache_name})

GLOBALCACHES = Caches()

## profiling

def capture_output(func):
   stdout = sys.stdout
   sys.stdout = StringIO()
   result = func()
   output = sys.stdout.getvalue()
   sys.stdout = stdout
   return result, output

import line_profiler
line_profile = line_profiler.LineProfiler()

def printprofile(file='aux/cProfile_aux.stats', num=20, callers=False):
   p = pstats.Stats(file)
   p.sort_stats(SortKey.TIME).print_stats(num)
   p.sort_stats(SortKey.CUMULATIVE).print_stats(num)
   if callers:
      p.sort_stats(SortKey.TIME).print_callers(num)
      p.sort_stats(SortKey.CUMULATIVE).print_callers(num)

def ensure_file_exists(file_path):
    directory = os.path.dirname(file_path)
    if not os.path.exists(directory): os.makedirs(directory)
    if not os.path.exists(file_path): 
       with open(file_path, 'w'): pass  


def my_profile(cmd, log_file=None, log_string=''):
   ensure_file_exists(profiling_aux_file := RadixRootdir + 'aux/cProfile_aux.stats')
   cProfile.run(cmd, profiling_aux_file)
   result = capture_output(lambda: printprofile(profiling_aux_file, num=50, callers=True))[1]
   with open(log_file, 'a') as f: f.write(f'{log_string}\n{result}')
   print(result)
   line_profile.print_stats(output_unit=1e-03)

def GetTimestamp()      : return datetime.datetime.now().strftime("%y.%m.%d-%H_%M_%S")
def GetShortTimestamp() : return GetTimestamp()[:8]

class Logger:
   def __init__(self, directory)    : self.directory = directory; ensure_file_exists(self.file())
   def directory_file(_, directory) : return f'{LogDir}{directory}/LOG{GetShortTimestamp()[:8]}.txt'
   def file(self)                   : return self.directory_file(self.directory)
   def __call__(self, text, directory=None):
      log_file = self.directory_file(directory) if directory else self.file()
      with open(log_file, 'a') as f: f.write(f'{GetTimestamp()}: {text}\n')

Log = Logger('default')

def Write(text, file):
   with open(file, 'w') as f: f.write(text)

class Mprinter:
   def __init__(self): self.printing_on = True
   def __call__(self, *args, **kwargs): 
      if self.printing_on: print(*args, **kwargs)

mprint = Mprinter()

def excise_substrings(text, div1, div2):
   return splits[0] if len(splits := text.split(div1))==1 else ''.join(x.rsplit(div2, 1)[-1] for x in splits)

psutil_process = psutil.Process(os.getpid())
def current_MBs_RAM()       : return round(psutil_process.memory_info().rss / (1024 * 1024), 1)
def exceeding_RAM_ceiling() : return current_MBs_RAM() > G_RAM_ceiling

G_Err_value = ''
def obj_diff(result1,result2):
   print('')
   print('printing obj_diff of the two results:')
   global G_Err_value
   G_Err_value = [result1, result2]
   if type(result1)==set or type(result1) == dict:
      from dictdiffer import diff
      for change in diff(result1, result2):
         print(change[:-1])
         if change[0] == 'change' : print(test_strings_compare(*change[-1]))
         else                     : print(str(change)[:250])
         G_Err_value.append(change)
   else:
      for attr, value1 in vars(result1).items():
         value2 = getattr(result2, attr)
         if value1 != value2:
            print(attr)
            if type(value1) == dict:
               for change in diff(value1, value2):
                  print(change)
                  G_Err_value.append((attr, change))
   print('')

class Aggregator:
   def __init__(self, values=None, divider=''):
      self.values = values if values is not None else []
      self.divider = divider
   def __lshift__(self, value): self.values.append(value)
   def has_any(self) : return len(self.values) > 0
   def __call__(self): return self.divider.join(self.values)

def unionfold(sets)             : return set().union(*sets)
def DictFun_Map(d, fun)         : return {k:fun(v) for k,v in d.items()}
def Dict_Nonempties(key_values) : return {key for key, values in key_values.items() if len(values)>0}
def Dicts_Union(dicts)          : return {k: v for d in dicts for k, v in d.items()}
def Dict_Reversed(d)            : return {v:k for k,v in d.items()}

def ListPredicate_Divide(xs, predicate):
   yes, no = [], []
   [(yes if predicate(x) else no).append(x) for x in xs]
   return yes, no

def fully_flatten(xs):
   match xs:
      case list(): return [y for x in xs for y in fully_flatten(x)]
      case _     : return [xs]

def ListPredicate_ChompUntil(xs, predicate):
   satisfied = list(takewhile(lambda x: not predicate(x), xs))
   return satisfied, xs[len(satisfied):]

# maybe should do such that we don't copy if single? 
def ItemSets_Merged(Item_Sets):
   d = {}
   for Item_Set in Item_Sets:
      for item,items in Item_Set.items():
         d.setdefault(item, set()).update(items)
   return d

def test_strings_compare(s1, s2):
   print('printing difference of the two strings:')
   s1,s2 = repr(s1),repr(s2)
   def report_string(s):
      return s[max(0,i-200):i] + RGBtext_Terminalcolored((250, 20, 20), s[i:i+100])
   for i in range(min(len(s1), len(s2))):
      if s1[i] != s2[i]:
         return '\n' + '\n'.join([report_string(s1), report_string(s2)])
   return f'found no difference. start: {s1[:150]} ...'

def RGBtext_Terminalcolored(rgb, text):
   return f"\033{chr(91)}38;2;{rgb[0]};{rgb[1]};{rgb[2]}m{text}\033{chr(91)}0m"

@dataclass
class Unique_ID_maker:
   id: int = 0
   def new(self):
      self.id += 1
      return str(self.id)
   def maybe_reset(self, new_id_count):
      if new_id_count is not None: self.id = new_id_count

ID_maker = Unique_ID_maker()

def Directory_Files(directory): return [os.path.join(directory, filename) for filename in sorted(os.listdir(directory))]

def get_multiproc_id():
   try: return multiprocessing.current_process().name.split("-")[1]
   except: return "proc (none)"

