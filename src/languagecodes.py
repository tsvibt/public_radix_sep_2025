'''
https://en.wiktionary.org/wiki/Category:Proto-Indo-European_language
languagecodes
'''

from src.shared_state import DB
from src.ordering import *
from src.db import * 
from src.wiktionary_autoconfig import * 

import copy
import ast

'''
!!!
WARNING
!!!
This caches the thingies. so have to delete the files in order for changes to show. could try something more complicated. or could just put these in ... yet another table. but its annoying because i want to do this stuff befoere loading db etc...
!!!
'''

#Langname_Code = DB._LangnameCode.OneValue() or {}

#GCode_Rectify = DB._CodeRectified.OneValue() or {}

#DB._CodeLangs.OneValue() = DB._DB._CodeLangs.OneValue().OneValue() or {}


####


def LangLang_isFutureward(lang1, lang2) : return lang1 in DB._PIElangposet.OneValue().strict_ulteriors.get(lang2, set())
def LangLang_isPastward(lang1, lang2)   : return LangLang_isFutureward(lang2, lang1)


