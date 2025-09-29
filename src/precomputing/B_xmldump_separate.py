"""
python src/precomputing/B_xmldump_separate.py
"""
from src.precomputing.coordinator import *

def Wiktionaryfile_Generator():
   chunk_size = 1024**3//10
   leftover = ''
   with open(Wiktionary.xml_full_path, 'r') as file:
      while (chunk := file.read(chunk_size)):
         page_chunks = chunk.split('</page>')
         page_chunks[0] = leftover + page_chunks[0]
         for page_chunk in page_chunks[:-1]: yield (page_chunk.split('<page>')[-1],)
         leftover = page_chunks[-1]

def has_included_lang(text):
   chunks = re.split(r'(==+)', text)
   for i,chunk in enumerate(chunks):
      if i%2==0 and i>0 and i<len(chunks)-1:
         if chunks[i-1]=='==' and chunks[i+1]=='==':
            if chunk in DB._IncludeLangnames.OneValue():
               return True
   return False


def excludeTitle(title): return ':' in title and not title.startswith('Reconstruction:')

def FUN(text):
   title_section, body = text.split('</title>')
   title = title_section.split('<title>')[1]
   if not excludeTitle(title) and not '<redirect title="' in body and has_included_lang(body):
      body = body.replace('wplink==', 'wplink=xx').replace('fake====', 'fake=xxx').replace(
                           'fake===', 'fake=xx').replace('fake==', 'fake=xx')
      body = '<comment> </comment>'.join([x.split('</comment>')[-1] for x in body.split('<comment>')])
      if not globals().get('G_Server_mode', False): print(title, end=' ')
      return [(title, body)]
   else:
      return []

to_do_1 = {'generator source':(9450000, Wiktionaryfile_Generator()), 'function':FUN, 'target tables':[DB._Gramtitle_XML], 'printing_args':False}

CALL([to_do_1,])
    

