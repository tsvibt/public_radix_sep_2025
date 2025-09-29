
from src.precomputing.multi_coordinator import *
from src.parsearticle import * 

def FUN(gramtitle, xml):
#   try:
   langname_parsed = XML_Dict(xml)
#   except:
#      Log((message := f'FAILED TO PARSE {gramtitle}\n'))
#      print(message)
#      return 

   for langname, parsed in langname_parsed.items():
      if langname == 'PRElang'           : pass
      elif langname not in DB._LangnameCode.OneValue(): Log(f'parse error: langname "{langname}" not in lang_code, article "{gramtitle}"')
      elif langname in DB._IncludeLangnames.OneValue(): 
         DB._GRAM_Parsed.Row_QueuePair((Gram(Gramtitle_Gramtext(gramtitle), DB._LangnameCode.OneValue()[langname]), parsed))

if __name__ == "__main__":

   to_do_1 = {'generator source':DB._Gramtitle_XML, 'function':FUN, 'target tables':[DB._GRAM_Parsed], }

   CALL([to_do_1, ])



