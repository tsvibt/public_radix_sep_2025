"""

exec(open('src/scraping/scrape_etymonline_PIE.py').read())

"""

exec(open('src/utilities.py').read())

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

list_of_cognate_lists = []

for letter in string.ascii_lowercase:
   url = 'https://www.etymonline.com/search?q=' + letter + '&type=5'
   driver.get(url)
   time.sleep(2)
   page_count = len(driver.find_elements(By.CLASS_NAME, 'ant-pagination-item'))
   print('getting ', page_count, ' pages from ', url)
   for i in range(1, 1+page_count):
      count_url = 'https://www.etymonline.com/search?page=' + str(i) + '&q=' + letter + '&type=5'
      print('getting from ', count_url)
      driver.get(count_url)
      time.sleep(2)
      paragraphs = driver.find_elements(By.TAG_NAME, 'p')
      cognate_lists = [p for p in paragraphs if p.text.startswith('It forms all or part of:')]
      list_of_cognate_lists.extend([[e.text for e in cognate_list.find_elements(By.TAG_NAME, 'a')] for cognate_list in cognate_lists])



RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'
with open(RadixRootdir + 'resources/etymonline_cognate_lists.txt', 'wb') as f:
    f.write(pickle.dumps(list_of_cognate_lists))

driver.quit()




'''
# NOOO. just directly get the lists by look at <p> that start with "it forms all or part of" and then getting those lists. 



entry_urls = []

letter = 'w'
i= 1
url = 'https://www.etymonline.com/search?q=' + letter + '&type=5'
driver.get(url)
time.sleep(2)
page_count = len(driver.find_elements(By.CLASS_NAME, 'ant-pagination-item'))
print('getting ', page_count, ' pages from ', url)
for i in range(1, 1+page_count):
count_url = 'https://www.etymonline.com/search?page=' + str(i) + '&q=' + letter + '&type=5'
print('getting from ', count_url)
driver.get(count_url)
time.sleep(2)
paragraphs = driver.find_elements(By.TAG_NAME, 'p')



# getting the urls of  the PIE entries
      entry_elements = driver.find_elements(By.CLASS_NAME, 'word__name--TTbAA')
      new_urls = [element.get_attribute('href') for element in entry_elements]
      print('got urls: ', str(new_urls), '\n')
      entry_urls.extend(new_urls)



for entry_url in entry_urls:





   i = 0
   words = [None]



   <ul class="ant-pagination pagination--1DEpf" unselectable="unselectable"><li title="Previous Page" tabindex="0" class="ant-pagination-disabled ant-pagination-prev" aria-disabled="true"><a role="button" href="/search?page=0&amp;q=t&amp;type=5">Prev</a></li><li title="1" class="ant-pagination-item ant-pagination-item-1 ant-pagination-item-active" tabindex="0"><a role="button" href="/search?page=1&amp;q=t&amp;type=5">1</a></li><li title="2" class="ant-pagination-item ant-pagination-item-2" tabindex="0"><a role="button" href="/search?page=2&amp;q=t&amp;type=5">2</a></li><li title="Next Page" tabindex="0" class=" ant-pagination-next" aria-disabled="false"><a role="button" href="/search?page=2&amp;q=t&amp;type=5">Next</a></li></ul>


url = 'https://www.etymonline.com/search?q=t&type=5'
len(driver.find_elements(By.CLASS_NAME, 'ant-pagination-item'))


driver.get(url)
time.sleep(2)
pagination_element = driver.find_elements(By.CLASS_NAME, 'ant-pagination')[0]

len(pagination_element.find_elements(By.CLASS_NAME, 'ant-pagination-item'))



ant-pagination-item-2

   while len(words) > 0:
      i+=1
      url = 'https://www.etymonline.com/search?page=' + str(i) + '&q=' + letter + '&type=5'
      print('getting from ', url)
      driver.get(url)
      time.sleep(2)
      words = driver.find_elements(By.CLASS_NAME, 'word__name--TTbAA')
      new_urls = [element.get_attribute('href') for element in words]
      print('got urls: ', new_urls)
      entry_urls.extend(new_urls)



for entry_url in entry_urls:



>>> [element.href for element in words]


      get words
      put words in list
      i+=1

acc = ''

for url in ['https://www.etymonline.com/search?q=' + letter + '&type=5'
               for letter in string.ascii_lowercase]:
   print('getting from', url)

url='https://www.etymonline.com/search?q=w&type=5'


url='https://www.etymonline.com/search?page=4&q=w&type=5'

driver.get(url)
time.sleep(2)
words = driver.find_elements(By.CLASS_NAME, 'word__name--TTbAA')
[element.get_attribute('href') for element in words]


https://www.etymonline.com/search?page=1&q=w&type=5
https://www.etymonline.com/search?page=2&q=w&type=5

https://www.etymonline.com/search?page=4&q=w&type=5

   [0].text.split('m[')


   <a class="word__name--TTbAA word_thumbnail__name--1khEg" style="margin-bottom:5px;display:block" title="Origin and meaning of *we-" href="/word/*we-#etymonline_v_53695">*we-<!-- -->&nbsp;<span class="word_thumbnail__name_icon--2RFFN"><i class="fa fa-chevron-right" style="font-size:16px"></i></span></a>

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


'''
