"""
python src/site/server.py
python src/tests.py test
python src/tests.py fulltest
"""

from src.printing.html import *
from src.printing.definitions import *
from src.printing.language_specific import *
from src.printing.gram_elements import *
from src.printing.wiktionary import *
from src.printing.inspection import *
from src.printing.inspection_html import *
from src.printing.report import *
from src.printing.cognates import *
from src.printing.settings import *
from src.printing.asynch import *
from src.printing.markdown import *

import ujson


## ---------------- Printing --------------------


G_page_names = ['home', 'why', 'usage', 'output', 'how', 'warning', 'vision', 'future', 'assist', 'about', 'settings' ]
G_nonpage_tabs = []
#G_nonpage_tabs = ['random_gram']

def Robots():
   return "User-agent: * \n" + '\n'.join('Allow: /_' + x for x in G_page_names) + "\nDisallow: /"

def Alpha_banner():
   return '<p style="color:red">Alpha/draft version. <span style="background-color:rgb(120, 50, 50)">READ THE WARNING.</span> DO NOT LINK widely. Typo/bug/feature reports not helpful ATM :)</p>'

def Button_panel():
   return ''.join(f'<a id="button-panel-{page}" href="/_{page}" class="page-button">{page}</a>' for page in G_page_names + G_nonpage_tabs)  + '<div class="horizontal-line"></div><br>' 

def pagename_html(path):
   if path[0]=='_' and path[1:] in G_page_names:
      html_content = Markdown_HTML(Read(f'{PagesDir}/{path}.md'))
      javascript_content = f'const js_page_name = "{path[1:]}";'
      return Displaycontent_HTML({'HTML_CONTENT':html_content, 'JAVASCRIPT_CONTENT':javascript_content, 'TITLE':path[1:]})
   else:
      return ''

def RandomGramtext(): return 'gram'

def Aux_HTML(): return '\n'.join(Read(file) for file in reversed(Directory_Files(f'{SiteDir}html/')))

def Displaycontent_HTML(contents):
   contents['HTML_HEADER'] = Alpha_banner() + Button_panel() 
   contents['AUX_HTML'] = Aux_HTML() 
   contents['CSS'] = Standard_CSS() 
   contents['TITLE'] = 'α] ' + contents['TITLE']
   contents['JAVASCRIPT_CONTENT'] += f'''
                  const js_langcolor_defaults  = {js_langcolor_defaults()};
                  const js_coglangs_cached     = {sorted(list(G_Cached_Coglangs))};
                  const js_coglangs_default    = {sorted(list(G_Default_Coglangs))};
                  const js_appearance_defaults = {js_appearance_defaults()};
                  '''
   result = Read(SiteDir + 'display.html')
   for thing, content in contents.items():
      result = result.replace(thing + '_PLACEHOLDER', content)
   return result

def Word_ErrorDisplaycontent(word):
   return {'HTML_CONTENT':f'for some reason, there was an error with word {word}', 'JAVASCRIPT_CONTENT':'', 'TITLE':'error'}

def Word_CognatesHTML(word) : return Displaycontent_HTML(Word_CognatesDisplayContent(word))
def Word_ReportHTML(word)   : return Displaycontent_HTML(Word_ReportDisplayContent(word))

