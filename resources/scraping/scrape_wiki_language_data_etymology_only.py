#python3 src/scraping/scrape_wiki_language_data_etymology_only.py 

import os 
import urllib.request
import requests
import time
import string
import ast
import certifi

from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup

driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

url = 'https://en.wiktionary.org/wiki/Module:etymology_languages/data'
print('getting from', url)
driver.get(url)
time.sleep(2)
code = driver.find_elements(By.TAG_NAME, 'pre')[0].text

print('writing...')
RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'
open(RadixRootdir + 'resources/wikt_languages_data_etymology_only.lua','w').write(code)

driver.quit()

