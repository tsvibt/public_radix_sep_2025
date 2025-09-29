"""
python src/precomputing/run_all.py
python src/site/server.py
python src/tests.py test
python src/tests.py fulltest
"""

from src.shared_state import SharedState
from src.utilities import *
from src.db import *

def File_isSubuniverse(file): return file.split('/')[-1].startswith('SUBUNIVERSE')

class WiktionaryContext:
   def __init__(self, xml_file):
      assert xml_file.endswith('.xml'), print(f'bad wiktionary xml path {xml_path}')

      self.filestem = '.'.join(xml_file.split('/')[-1].split('.')[:-1])
      self.main_name = self.filestem if not File_isSubuniverse(xml_file) else self.filestem.split('__')[1]  

      self.main_directory = f'{WiktionariesDir}{self.main_name}/'
      self.xml_full_path = self.main_directory + xml_file
      self.databases_directory = f'{self.main_directory}DBs/'
      if not os.path.exists(self.databases_directory): os.makedirs(self.databases_directory)
      self.db_dir = self.most_recent_databases_directory()
      self.checkpoint_db_dir = f'{self.databases_directory}Checkpoint_{self.filestem}/'

      print(f'db file is {self.db_dir}')
      if self.db_dir is not None: DB_activate(self.db_dir)

   def new_db_dir(self): return f'{self.databases_directory}{self.filestem}-{GetTimestamp()}/' 
   def most_recent_databases_directory(self):
      for directory in reversed(sorted(next(os.walk(self.databases_directory))[1])):
         if directory.startswith(self.filestem): return f'{self.databases_directory}{directory}/'
      return None

Wiktionary : WiktionaryContext = SharedState()


Wiktionary._SET_(WiktionaryContext(WiktionaryXMLfile))


