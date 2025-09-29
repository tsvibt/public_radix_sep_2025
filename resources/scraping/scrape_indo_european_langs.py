"""
exec(open('resources/scraping/scrape_indo_european_langs.py').read())
"""

import os 
import urllib.request
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import certifi
import requests
from bs4 import BeautifulSoup

driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

url = 'https://en.wiktionary.org/wiki/Category:Proto-Indo-European_language'
driver.get(url)
time.sleep(2)

page_source = driver.page_source
soup = BeautifulSoup(page_source, 'html.parser')
top_node = soup.find_all(class_='familytree')[0]

def firstchild(x):
   return list(x.children)[0]

top_list_item =firstchild(firstchild(top_node))

def Listitem_Tree(list_item):
   node = 'none'
   is_proto = False
   children = []
   for s in list_item.contents:
      if s.name == 'span' and ('familytree-lang' in s['class'] or 'familytree-etymlang' in s['class'] or 'familytree-family' in s['class']):
         node = s.text
      if s.name == 'span' and 'familytree-linedrawing' in s['class']:
         if not any(child.name == 'span' and ('familytree-branch' in child['class'] or 'familytree-toggle' in child['class']) for child in s.contents):
            is_proto = True
            print(list_item.contents[2].text)
      elif s.name == 'ul':
         children = [Listitem_Tree(child) for child in s.contents]
   return {'node': node, 'children': children, 'is_proto': is_proto}


def get_langcode(text):
   return text.split('(')[1].split(')')[0]

def correct_Tree(tree):
   if len(tree['children'])==0 or not tree['children'][0].get('is_proto', False):
      tree['real'] = tree['node']
   else:
      assert len(tree['children'][0]['children']) == 0 , print(tree)
      tree['real'] = tree['children'].pop(0)['node']
   tree['real'] = get_langcode(tree['real'])
   [correct_Tree(child) for child in tree['children']]

def Tree_Itemimmediatefutures(tree, Item_Futures={}):
   Item_Futures[tree['real']] = set([child['real'] for child in tree['children']])
   [Tree_Itemimmediatefutures(child, Item_Futures) for child in tree['children']]
   return Item_Futures
   
languages_order_tree = Listitem_Tree(top_list_item)
correct_Tree(languages_order_tree)
immediate_futures_text=repr(Tree_Itemimmediatefutures(languages_order_tree))

tree_text = driver.find_elements(By.CLASS_NAME, 'familytree')[0].get_attribute("textContent")
text = tree_text.replace('\xa0', '').replace('Collapse', '')
language_text = '\n'.join([language.split('(')[0].strip(' EF').strip('│├[-─]┬ └') for language in text.split(')')[:-1]])

driver.quit()

RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'
open(RadixRootdir + 'resources/proto-indo-european-langs-tree.txt','w').write(immediate_futures_text)
open(RadixRootdir + 'resources/proto-indo-european-langs.txt','w').write(language_text)


