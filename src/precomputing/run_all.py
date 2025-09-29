"""
python src/precomputing/run_all.py
python src/site/server.py
"""

import subprocess
from src.radix import *

x = '''
U_basiclangcodes
V_PIE
A_xmldump_redirects
B_xmldump_separate
C_AB_xmls_parse
D_C_parsed_allmentioners
E_C_parse_linksrefs
Q_E_futurelinks_wordgramrefs
F_E_linksrefs_pastwardsfuturewards
G_F_grampastmosts
H_G_gram_immediatefutures
I_G_gram_strictfutures
K_C_parsed_realgivenwords
M_I_gram_lang_allfutures
N_QGI_gram_coverings
O_KN_word_pastwardwordposet
P_O_pastmostword_futurewordposet
T_gramorder_sortkey
''' 
''' 
commongramslist
9_commongrams_html
'''

#MODE = 'scalene'

#DB_activate(Wiktionary.new_db_dir())

for file_name in x.strip().split('\n'):
   if not file_name.startswith('#'):
      if globals().get('MODE', 'normal') == 'scalene':
         cmd = f'scalene --profile-all {SourceDir}precomputing/{file_name}.py'
         check = False
      else:
         cmd = f'python {SourceDir}precomputing/{file_name}.py'
         check = True
      print(f'\nexecuting: {cmd}\n')
      subprocess.run(cmd, shell=True, check=check)



