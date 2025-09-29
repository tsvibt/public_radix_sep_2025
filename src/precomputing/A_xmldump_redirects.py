'''
python src/precomputing/A_xmldump_redirects.py
'''

from src.precomputing.coordinator import *

import subprocess

#DB_activate(Wiktionary.new_db_dir())

print('searching for redirects...')
command = f"""rg --no-ignore -B 5 '<redirect title="' {Wiktionary.xml_full_path}"""
result = subprocess.run(command, shell=True, capture_output=True, text=True).stdout

print('got redirects, making dictionary...')
def Text_MaybeTitleRedirect(text):
   try:
      title = text.split('</title>')[0]
      redirect = text.split('<redirect title="')[1].split('"')[0]
      print('redirecting', title, 'to', redirect)
      return (title, redirect)
   except:
      return None

G_Gramtitle_Redirect = {title:redirect for title, redirect in 
           filter(None, map(Text_MaybeTitleRedirect, result.split('<title>')))}

to_do_1 = OBJECT_TABLE_TODO(G_Gramtitle_Redirect, DB._GramtitleRedirect, dict_single_value=True)

CALL([to_do_1])

