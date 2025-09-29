"""
exec(open('src/scraping/scrape_wiki_language_data.py').read())
"""
#######
#######
#######

#WARNING: running this tends to break stuff. which sucks. but. 

#######
#######
#######

import os 
import urllib.request
import requests
import time
import string
import certifi

from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup

driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

acc = ''
for url in ['https://en.wiktionary.org/wiki/Module:languages/data/2', 'https://en.wiktionary.org/wiki/Module:languages/data/exceptional'] + ['https://en.wiktionary.org/wiki/Module:languages/data/3/' + letter for letter in string.ascii_lowercase]:
   print('getting from', url)
   driver.get(url)
   time.sleep(3)
   code_split=driver.find_elements(By.TAG_NAME, 'pre')[0].text.split('m[')
   acc += 'return'.join('m['.join([''] + code_split[1:]).split('return')[:-1])
   if url == 'https://en.wiktionary.org/wiki/Module:languages/data/2':
      start = code_split[0]

start = '\n'.join(['local m_langdata = dofile("/Users/tbt/programming/radix/resources/Module_languages_code.lua")' if line.startswith('local m_langdata') else line for line in start.split('\n')])

text = """
function()
mw = {ustring = require 'ustring/ustring'} 
""" + start + acc + """
return m
end
"""



print('writing merged...')
RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'
open(RadixRootdir + 'resources/wikt_languages_data_merged.lua','w').write(text)

driver.quit()

