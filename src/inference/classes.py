
from src.utilities import *
from src.classes import *

from src.abstract_regex import Primitive, Pattern, Automata, OR, Structure

G_code_fun = {'OR' : any,
              'AND': all,
              'NOT': lambda x: not any(x)}

def CodeNameRecognizer_Regex(code, name, arg, kind):
   match code:
      case 'OR'|'AND'|'NOT': return Primitive(name, lambda tok: G_code_fun[code](regex.test(tok) for regex in arg))
      case 'Primitive'     : return Primitive(name, lambda tok: tok['kind'] == kind and arg(tok['content']))
      case 'Pattern'       : return Pattern(name, arg)

def _Element_RecursiveTokens(element):
   if isinstance(element, Structure) : return list(map(_Element_RecursiveTokens, element.elements))
   else                              : return element.token

def _PatternTokens_Matches(pattern, tokens):
   automaton = Automata(pattern)
   for i,token in enumerate(tokens) : automaton.feedToken(dict(token,index=i)) 
   return [[_Element_RecursiveTokens(element)
         for element in final_state.connect(automaton.pattern.name)[1].elements]
         for final_state in list(automaton.finalStates)]

G_inference_objects = []

class Inference_object:
   def __init__(self, kind, regex_object, header, extractor, direction):
      self.name = kind + '_Inference_' + header.split(' ')[0] + '_' + regex_object.__str__().split('Pr_')[-1].split('P_')[-1]
#      globals()[self.name] = self
      self.kind, self.regex_object, self.header, self.direction = kind, regex_object, header, direction
      G_inference_objects.append(self)

      if isinstance(regex_object, Primitive): self.matches = lambda tokens: [[x] for x in filter(regex_object.test, tokens)]
      else                                  : self.matches = lambda tokens: _PatternTokens_Matches(regex_object, tokens)

      match extractor:
         case int() if kind == 'reference'          : self.raw_reflinks = lambda match, word: [match[extractor]]
         case tuple() if extractor[1] == 'pass_word': self.raw_reflinks = lambda match, word: extractor[0](match, word)
         case _                                     : self.raw_reflinks = lambda match, word: extractor(match)

   def reflinks(self, match, word):
      results = self.raw_reflinks(match, word)
      if self.kind == 'reference': 
         gram_token = {'kind': 'template', 'content': {'kind':'INFERRED', 'lang': word.lang, 'gramtexts':[word.text]}}
         results = [(gram_token, x) for x in results]
      results = [(tok1['content'], tok2['content']) for tok1, tok2 in results]
      if self.direction == 'pastward': results = [(ref2, ref1) for ref1, ref2 in results]
      return results

   def results(self, word, worddict):
      return [{'name':self.name, 'kind':self.kind, 'header':header, 'header tokens':tokens,
               'match_tokens':fully_flatten(match), 'reflinks':self.reflinks(match, word)}
              for header, tokens in worddict.items() if header.startswith(self.header) 
              for match in self.matches(tokens)]


