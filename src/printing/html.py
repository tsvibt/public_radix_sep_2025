
from src.utilities import *

def Text_Legendheader(text): return f'<h4>{text}</h4>'

def Tuples_HTMLtable(data):
   html = Aggregator(['<table>'])
   for row in data:
      html << '<tr>'
      [html << f'<td>{col}</td>' for col in row]
      html << '</tr>'
   html << '</table>'
   return html()

def Color(rgb, text): return f'''<span style="color: rgb{rgb}">{text}</span>'''

def Gray(x): return (x,x,x)

G_semicolon_element = Color(Gray(205), '; ')

def Darken(rgb, factor): return tuple(map(lambda x: int(x / factor), rgb))

def Element(tag, text, style = ''): return f'<{tag} style="{style}">{text}</{tag}>'
def Paragraph(text, style = ''): return Element('p', text, style)

Overlap_color = Gray(245)
Disoverlap_color = (200,165,0)
#Legend_color = (130,225,255)
#Legend_color_background = (210,70,240, .35)
Connector_color = Gray(200)
already_included_mark = '▲'
#already_included_mark = Color((230, 160, 50), ' ▲') 


def ClassColor_highlight(class_name, color):
   return f'''.{class_name} {{ outline:1px solid rgb{Darken(color, 1.39)};
               background-color:rgb{Darken(color, 2.95)};}}'''

#TODO move to js probably 
def Standard_CSS():
   styles = []
   styles.append(f'''
   .kind-summary_gramlist_trunk {{ outline: 1px solid rgb{Gray(140)}; }}
   .kind-inspection {{ white-space:nowrap; }}

   ''')
   styles.extend(ClassColor_highlight(class_name, color) for class_name, color in [
                 ('etymonline_only', (255, 80, 50)),
                 ('generally_excluded', Gray(150)),
                 ('etymonline_and_radix', (135, 140, 245)),
                    ])
   return '\n'.join(styles )


def Word_JScontent(word): return f'const js_starting_word = {{gramtext: "{word.text}", lang: "{word.lang}", word: "{word.num}"}};'

def Text_Legendheader(text):
   return f'<h4>{text}</h4>'


