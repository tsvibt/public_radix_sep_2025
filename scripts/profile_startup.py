'''
python scripts/profile_startup.py
successfully we have that onevalue only shows up once sortkey has been run, i.e. after everything has been run..
'''
#### profile startup

import cProfile
import pstats
from pstats import SortKey

import os 
RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'

def printprofile(file='aux/cProfile_aux.stats', num=20, callers=False):
   p = pstats.Stats(file)
   p.sort_stats(SortKey.TIME).print_stats(num)
   p.sort_stats(SortKey.CUMULATIVE).print_stats(num)
   if callers:
      p.sort_stats(SortKey.TIME).print_callers(num)
      p.sort_stats(SortKey.CUMULATIVE).print_callers(num)

def my_profile(cmd):
   profiling_aux_file = RadixRootdir + 'aux/cProfile_aux.stats'
   cProfile.run(cmd, profiling_aux_file)
   printprofile(profiling_aux_file, num=50, callers=True)

def Read(file, read_type='r'):
   with open(file, read_type) as f: return f.read()


import subprocess
pre_cmd = 'python src/precomputing/A_xmldump_redirects.py'
subprocess.run(pre_cmd, shell=True, check=True)

cmd = "exec(Read('src/radix.py'))"
my_profile(cmd)


line_profile.print_stats(output_unit=1e-03)



