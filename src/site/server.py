"""
python src/site/server.py
from src.site.server import *
"""

from src.radix import *
from src.printing.printing import * 

from flask import Flask, send_file, request, Response, redirect 
import mimetypes
import urllib.parse


def Optionstring_Options(option_string):
   return {option.split(':')[0]:option.split(':')[1] for option in option_string.split('&') if option!=''}

app = Flask(__name__)

Log.__init__('server')

# iirc the reason for this is so that the db is created after gunicorn splits off the process; so that we don't share db connections. should maybe simplify using hooks or something??
G_sql_not_yet_activated = True
def maybe_activate_sql():
   global G_sql_not_yet_activated
   if G_sql_not_yet_activated:
      DB_activate(Wiktionary.db_dir)
      G_sql_not_yet_activated = False 

@app.before_request
def log_request_info():
   maybe_activate_sql()
   Log(f"IP:{request.remote_addr}, method:{request.method}, path:{request.full_path}, data:{request.get_data().decode('utf-8')}")
   memstring = f'current memory usage: {current_MBs_RAM()}MB.'
   print(memstring)
   Log(memstring)

@app.route('/REDACTED.html', methods=['GET', ])
def serve_googleverify():
   return Response('google-site-verification: REDACTED.html', mimetype='text/plain')

@app.route('/robots.txt', methods=['GET', ])
def serve_robots():
   return Response(Robots(), mimetype='text/plain')

@app.route('/async_content', methods=['POST', ])
def serve_asynch():
   json_data = ujson.loads(request.get_data().decode('utf-8'))
   print(json_data)
   return send_html(Async_content(json_data))

@app.route('/', methods=['GET', ])
def serve_homepage():
   return redirect(request.host_url + '_home')

@app.route('/favicon.ico', methods=['GET',])
def serve_favicon():
   return serve_image('/images/radix_favicon.ico')

def mime_send_file(file_path):
    mime_type, _ = mimetypes.guess_type(file_path)
    return send_file(file_path, mimetype=mime_type)

def send_html(text):
   return Response(text, mimetype='text/html')

@app.route('/images/<param1>', methods=['GET',])
def serve_image(param1):
   if param1 in ['radix_favicon.ico', 'TriangleArrow-Down.svg', 'En.wiktionary_favicon.svg', 'etymonline_icon.png']:
      return mime_send_file(SiteDir + 'images/' + param1)
   else:
      return 'no'

@app.route('/<param1>', methods=['GET',])
def serve_anything(param1):
   if param1[0]=='_':
      if param1[1:] in G_nonpage_tabs:
         return redirect(request.host_url + 'word/' + RandomGramtext())
      return send_html(pagename_html(param1))
   return redirect(request.host_url + 'word/' + param1)

@app.route('/word/<param1>', methods=['GET',])
def serve_just_gram(param1):
   return redirect(f'/word/lang:none_given/{param1}')

@app.route('/word/<param1>/<param2>', methods=['GET',])
def serve_gram(param1, param2):
   gramtext = urllib.parse.unquote(param2.strip())
   if len(gramtext)>0:
      options = Optionstring_Options(param1)
      given_lang, given_wordnum = options.get('lang', 'none_given'), options.get('wordnum', 'none_given')
      word = GramtextLangWordnum_Realword(gramtext, given_lang, given_wordnum)
      if 'none_given' in [given_lang, given_wordnum]:
         return redirect(f'/word/lang:{word.lang}&wordnum:{word.num}/{word.text}')
      if not globals().get('G_Server_mode', False) and options.get('mode', None) == 'report':
         return send_html(Word_ReportHTML(word))
      else:
         return send_html(Word_CognatesHTML(word))
   else:
      return 'no word'

@app.route('/inspection/', methods=['POST',])
def serve_inspection():
   json_data = ujson.loads(request.get_data().decode('utf-8'))
   return Json_Inspection(json_data['inspect_gram'])

if __name__ == '__main__':
   app.run(host='0.0.0.0', port=80,  threaded=False, debug=True)



