"""
python scanning/scan_parsed.py
"""

from src.precomputing.coordinator import *

RED = (255, 80, 80) 

#def RGBtext_Terminalcolored(rgb, text):

test_extractor = big_ref_extractor
P_test = P_big
Inference_object('reference', P_big, 'Etymology', big_ref_extractor, 'pastward')

SECTION = 'Etymology'
KIND = 'reference'
DIRECTION = 'pastward'
test_inf_obj = Inference_object(KIND, P_test, SECTION, test_extractor, DIRECTION)
G_inference_objects = [test_inf_obj]

def GramParsed_Inferences(gram, parsed):
   return [inference for num, worddict in parsed.items() for inference in WordDict_Inferences(Word(gram, num), worddict)]

def FUN(gram, parsed):
   for ref_result in GramParsed_Inferences(gram, parsed):
      header_text = Tokens_Text(ref_result['header tokens'])
      match_text = Tokens_Text(fully_flatten(ref_result['match_tokens']))
      assert match_text in header_text
      text = header_text.replace(match_text, RGBtext_Terminalcolored((255,90,90), match_text))
      if len(ref_result['reflinks']) >0:
         print('in:', gram)
         print(text)

to_do_1 = {'generator source':DB._GRAM_Parsed, 'function':FUN, 'target tables':[], 'message': '', 'printing':False, 'printing_args':False}

CALL([to_do_1, ], to_profile=False)


