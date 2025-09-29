

t2['children'][0]


######
######
######

def Listitem_Tree(list_item):
   node = 'none'
   children = []
   for s in list_item.contents:
      if s.name == 'span' and ('familytree-lang' in s['class'] or 'familytree-etymlang' in s['class'] or 'familytree-family' in s['class']):
         node = s.text
#         if "familytree-hasprotolang" in s['class']:
#            node += 'HAS PROTO'
      elif s.name == 'ul':
         children = [Listitem_Tree(child) for child in s.contents]
   return {'node': node, 'children': children}


def correct_Tree(tree):
   if tree['node'].endswith('HAS PROTO'):
      if len(tree['children'][0]['children']) == 0:
         assert tree['children'][0]['node'].startswith('Proto-'), print(tree['node'])
         tree['real'] = tree['children'].pop(0)['node']
      else:
         tree['real'] = 'SKIP'
   elif tree['node'].strip().endswith(' F'):
      tree['real'] = 'SKIP'
   else:
      tree['real'] = tree['node']
   [correct_Tree(child) for child in tree['children']]

def Node_Immediatefutures(tree):
   print(tree['node'])
   futures = set()
   for child in tree['children']:
      print(child['node'])
      if child['real'] == 'SKIP':
         futures |= Node_Immediatefutures(child)
      else:
         futures.add(child['real'])
   return futures

def Tree_Itemimmediatefutures(tree, Item_Futures={}):
   if tree['real'] != 'SKIP':
      Item_Futures[tree['real']] = Node_Immediatefutures(tree)
   [Tree_Itemimmediatefutures(child, Item_Futures) for child in tree['children']]
   return Item_Futures
   

k= Listitem_Tree(t2)
correct_Tree(k)
z=Tree_Itemimmediatefutures(k)


i=0
def print_soup(s, off=''):
   global i
   if s.name == 'span' and 'familytree-family' in s['class']:
      print(off, 'F', s.text)
      i+=1
   elif s.name == 'span' and ('familytree-lang' in s['class'] or 'familytree-etymlang' in s['class']):
      print(off, 'L',  s.text)
      i+=1
   elif s.name == 'ul':
      for li in s.contents:
         for c in li.contents:
            print_soup(c, off+ ' ')


def print_soup(s, off=''):
   try:
      if 'familytree-family' in s['class']:
         print(off, 'F', s.text)
      elif 'familytree-lang' in s['class']:
         print(off, 'L',  s.text)
      elif s.name == 'ul':
         for li in s.contents:
            for c in li.contents:
               print_soup(c, off+ ' ')
   except:
      pass



Names = """
familytree-family
familytree-lang
familytree-code
familytree-linedrawing
familytree-branch
mw-customtoggle-familytree323
mw-customtoggle
familytree-hasprotolang
familytree-icon
familytree-etymlang
""".split('\n')

for x in top.find_all('span'):
   for c in x['class']:
      if c not in Names and not c.startswith('mw-customtoggle-familytree'):
         print(c)
         print(x)




#   [print(off, t.text) for t in s.find(class_='familytree-family')]
   #   [print(off, t.text) for t in s.find_all(class_='familytree-family')]
   #   [print(off, t.text) for t in s.select('.container :not(ul)')]
   #   [print(off,t.text ) for t in s.find_all(class_='familytree-lang')]
#   [print(off,t.text ) for t in s.find(class_='familytree-lang')]
   #   print(s.text[:100])
#   try:
#      for c in s.contents:
#         print_soup(c, off+ ' ')
#   except:
#      pass
#



def print_soup(s, off=''):
   [print(off, t.text) for t in s.find(class_='familytree-family')]
   #   [print(off, t.text) for t in s.find_all(class_='familytree-family')]
   #   [print(off, t.text) for t in s.select('.container :not(ul)')]
   #   [print(off,t.text ) for t in s.find_all(class_='familytree-lang')]
   [print(off,t.text ) for t in s.find(class_='familytree-lang')]
   #   print(s.text[:100])
   try:
      for c in s.contents:
         print_soup(c, off+ ' > ')
   except:
      pass


print(top.prettify()[:500])



def firstchild(x):
   y = list(x.children)[0]
   print(len(list(y.children)))
   return y


#
#def soup_tree(s):
#   return (s, [soup_tree(c) for c in s.contents])
#
#tt=soup_tree(top)
#
#
#print(top.prettify()[:5000])
#print(top.prettify())
#
#
#def index_elem(s, xs):
#   for x in xs:
#      s=s.contents[x]
#   return s
#

#
#i=[0,0,1]
#
#i=[0,0,2]
#print(index_elem(top, i).prettify()[:5000])
#
#i=[0,0,0]
#index_elem(top, i)
#
#def tprint():
#   print_soup(t1)
#
#if t1.name == 'span' and 'familytree-family' in t1['class']:
#   print('boop')
#
#
#includeLangNames
#
#tr = soup_tree(t1)
#
#def soup_tree(s):
#   if s.name == 'span' and ('familytree-lang' in s['class'] or 'familytree-etymlang' in s['class'] or 'familytree-family' in s['class']):
#      return [s.text]
#   elif s.name == 'ul':
#      return [x for li in s.contents for c in li.contents for x in soup_tree(c)]
#   else:
#      return []
#

hypothesis: if the
lindrawing thing has as subspan familytree branch, that is a protolang. otherwise no. 


<span class="familytree-linedrawing">│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├<span class="familytree-branch">────</span></span>

#top.find_all(class_='familytree-hasprotolang')
#[x for x in [x.text.split('(')[0].strip() for x in top.find_all(class_='familytree-hasprotolang')] if 'Proto-'+x not in top.text]

#s.name == 'span' and ('familytree-lang' in s['class'] or 'familytree-etymlang' in s['class'] or 'familytree-family' in s['class'])
#not any(child.name == 'span' and child['class'] == 'familytree-branch' for child in s.contents)

#s=list(list(list(t2.children)[2].children)[18].children)[0]
#s.name == 'span' and 'familytree-linedrawing' in s['class']
#not any(child.name == 'span' and 'familytree-branch' in child['class'] for child in s.contents)


#tree_text = driver.find_elements(By.CLASS_NAME, 'familytree')[0].get_attribute("textContent")

