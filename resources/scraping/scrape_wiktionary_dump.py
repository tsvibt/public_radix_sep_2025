"""
exec(open('resources/scraping/scrape_wiktionary_dump.py').read())
"""



import os 
import urllib.request
import time
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
import certifi
import requests


#https://stackoverflow.com/questions/76973528/the-chromedriver-version-detected-in-path-might-not-be-compatible-with-the-detec
# selenium 4.0
from selenium.webdriver.chrome.service import Service as ChromeService

driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))

#https://dumps.wikimedia.org/enwiktionary/20240501/enwiktionary-20240501-pages-articles.xml.bz2
url = 'https://dumps.wikimedia.org/enwiktionary/latest/enwiktionary-latest-pages-meta-current.xml.bz2'

driver.get(url)


