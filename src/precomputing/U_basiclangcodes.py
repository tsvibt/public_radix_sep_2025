'''
python src/precomputing/U_basiclangcodes.py
'''


from src.precomputing.coordinator import *

DB_activate(Wiktionary.new_db_dir())

def no_equals(entry):
   return '\n'.join(line for i,line in enumerate(entry.split('\n')) if i==0 or '=' not in line)

def luatext_entries(lua_text):
   return [entry.split('\n}\n')[0] for entry in lua_text.split('\nm[')[1:]]

def luatext_entrydict(lua_text, value_index):
   return {(entry_bits := no_equals(entry).split('"'))[1] : entry_bits[value_index] for entry in luatext_entries(lua_text)}

def Code_Langs(): 
   return luatext_entrydict(Read(f'{ResourcesDir}wikt_languages_data_merged.lua'), 3)


BasicCodeLangs = Code_Langs()
#BasicCodeLangs = thing if (thing := DB._BasicCodeLangs.OneValue()) else {}

Langname_Code = Dict_Reversed(BasicCodeLangs)


def EtymologyOnlyCode_Langs():
   mapping = luatext_entrydict((text := Read(f'{ResourcesDir}wikt_languages_data_etymology_only.lua')), 5)
   for entry in luatext_entries(text):
      for line in entry.split('\n'):
         if line.strip().startswith('alias_codes'):
            for code in line.split('"')[1::2]:
               mapping[code] = entry.split('"')[5]

   for k in mapping:
      while mapping[k] in mapping:
         mapping[k] = mapping[mapping[k]]
   return mapping


Code_Rectify = EtymologyOnlyCode_Langs()
assert Code_Rectify is not None

CodeLangs = {k:BasicCodeLangs[v] for k,v in Code_Rectify.items()} | BasicCodeLangs
CodeLangs['language-code'] = 'Full Language Name'
CodeLangs['DEFAULT']       = 'default language'

def _Langname_age(lang):
   if lang in ['English', 'German'] : return -1
   if lang.startswith('New ')       : return 1
   if lang.startswith('Middle ')    : return 2
   if lang.startswith('Old ')       : return 3
   if lang == 'Latin'               : return 4
   if lang.startswith('Ancient ')   : return 5
   if lang.startswith('Proto-')     : return 6
   if lang == 'Proto-Indo-European' : return 7
   else                             : return 0

_G_code_age = DictFun_Map(CodeLangs, _Langname_age)


#to_do_1 = OBJECT_TABLE_TODO(Code_Langs(), DB._BasicCodeLangs, dict_single_value=True)
#to_do_1 = OBJECT_TABLE_TODO(Langname_Code, DB._LangnameCode, dict_single_value=False)
to_do_1 = OBJECT_TABLE_TODO(Langname_Code, DB._LangnameCode, dict_single_value=True)
to_do_2 = OBJECT_TABLE_TODO(Code_Rectify, DB._CodeRectified, dict_single_value=True)
to_do_3 = OBJECT_TABLE_TODO(CodeLangs, DB._CodeLangs, dict_single_value=True)
to_do_4 = OBJECT_TABLE_TODO(_G_code_age, DB._LangAge, dict_single_value=True)

CALL([to_do_1, to_do_2, to_do_3, to_do_4, ])

