"""
exec(open('src/scanning/scan_links.py').read())
"""
exec(open('src/precomputing/abstracted.py').read())

def terminal_rgb_col(r, g, b):
   return "\033[38;2;{};{};{}m".format(r, g, b)

def fun_nested_map(fun, xs):
   if type(xs) == list : return [fun_nested_map(fun, x) for x in xs]
   else                : return fun(xs)

test_extractor = big_ref_extractor
P_test = P_big
Inference_object('reference', P_big, 'Etymology', big_ref_extractor, 'pastward')

SECTION = 'Etymology'
KIND = 'reference'
DIRECTION = 'pastward'
test_inf_obj = Inference_object(KIND, P_test, SECTION, test_extractor, DIRECTION)
G_inference_objects = [test_inf_obj]

def GramParsed_Inferences(gram, parsed):
   return [inference for num, worddict in parsed.items() for inference in _WordDict_Inferences(Word(gram, num), worddict)]

def FUN(gram, parsed):
   for ref_result in GramParsed_Inferences(gram, parsed):
      header_text = _Tokens_Text(ref_result['header tokens'])
      match_text = _Tokens_Text(fully_flatten(ref_result['match']))
      assert match_text in header_text
      text = header_text.replace(match_text, RGBtext_Terminalcolored((255,90,90), match_text))
      if len(ref_result['reflinks']) >0:# and not any(PIE_langcode_poset.strict_ulteriors[next_lang] == set() for next_lang in PIE_langcode_poset.immediate_ulteriors[word.lang]):
         print('in:', word)
#         print(fun_nested_map(lambda token: token['content'] if token['kind'] == 'text' else token['content']['text'], ref_result['match']))
         print(text)
#         print(ref_result['reflinks'])
#         print([w for w in ref_result['extractions']['content']['wordtexts'] if '/' in w])
   return []

to_do_1 = {'generator source':SQL_WORD_Parsed, 'function':FUN, 'target tables':[SQL_SANDBOX], 'message': '', 'limit':9000000, 'printing': False}

CALL([to_do_1, ], to_profile=False)




