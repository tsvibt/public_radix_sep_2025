"""
exec(open('scanning/scan_xml.py').read())
"""

exec(open('src/precomputing/abstracted.py').read())

RED = (255, 80, 80) 
def TerminalColor(rgb, text):
   return terminal_rgb_col(*rgb) + text + '\033[0m'

def terminal_rgb_col(r, g, b):
   return "\033[38;2;{};{};{}m".format(r, g, b)

def TextReplace_Red(text, replace):
   return text.replace(replace, TerminalColor(RED, replace))


count = 0
def FUN(wordtitle, xml):
   global count
   div = '{{'
   if div in xml:
      thing = xml.split(div)[1]
      if '}}' not in thing:
         count +=1 
         print('count:', count)
         print('title:', wordtitle)
         print('text:', TextReplace_Red(xml, thing))
   return []

to_do_1 = {'generator source':SQL_Wordtitle_XML, 'function':FUN, 'target tables':[SQL_SANDBOX], 'message': '', 'printing':False, 'printing_args':False}

CALL([to_do_1, ], to_profile=False)

'''

exec(open('src/radix.py').read())
word = Word('Clio', 'en')
pprint(Word_Parsed(word))

word = Word('accipient', 'en')



'''

