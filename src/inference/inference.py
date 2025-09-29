"""
https://stackoverflow.com/questions/61525719/abstract-regular-expressions
python src/tests.py fulltest
"""
from src.shared_state import * 
from src.utilities import * 

from src.inference.classes import * 
from src.inference.refs_links import * 
from src.inference.big_regex import * 

def Ref_Grams(ref): return {Gram(gramtext, ref['lang']) for gramtext in ref['gramtexts']}

def Reflinks_Gramlinks(reflinks):
   return {(link_from_gram, link_to_gram)
         for from_ref, to_ref in reflinks
         for link_from_gram, link_to_gram in product(Ref_Grams(from_ref), Ref_Grams(to_ref))}

def Word_Inferences(word): return WordDict_Inferences(word, word.Parsed())

def WordDict_Inferences(word, worddict):
   return [result for inf_obj in G_inference_objects for result in inf_obj.results(word, worddict)]

def _Inference_Gramlinks(inference): return Reflinks_Gramlinks(inference['reflinks'])

def WordDict_Gramlinks(word, worddict):
   return {gramlink for inference in WordDict_Inferences(word, worddict) for gramlink in _Inference_Gramlinks(inference)}

def Gram_FutureGramlinks(gram):
   return {(word, past_gram, future_gram) for word in gram.GivensOrPlaceholder() 
                                         for past_gram, future_gram in word.FutureGramlinks()}



