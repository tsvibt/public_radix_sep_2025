
from src.shared_state import DB
from src.classes import * 
 
from src.inference.inference import * 
from src.printing.html import *
from src.printing.gram_elements import *

from itertools import combinations

def Tokens_Text(tokens) : return ''.join(map(_Token_Text, tokens))
def _Token_Text(token)   : return token['content'] if token['kind'] == 'text' else token['content']['text']


def _GramKind_Neighborhood(gram : Gram, neighborhood):
   match neighborhood:
      case 'global': return {gram} | gram.AllMentioningGrams()
      case 'local' : return {gram} | gram.Direction_Givenrefgrams('futureward') | gram.Direction_Givenrefgrams('pastward')

######

def _GramGram_Mentionerlists(gram1, gram2, neighborhood):
   inspections = {'futureward':[], 'pastward':[]}
   for source_gram in (_GramKind_Neighborhood(gram1, neighborhood) | _GramKind_Neighborhood(gram2, neighborhood)):
      for source_word, past_gram, future_gram in Gram_FutureGramlinks(source_gram):
         if {past_gram, future_gram} == {gram1, gram2}:
            inspections['futureward' if past_gram == gram1 else 'pastward'].append(source_word)
   return inspections

def _SWAP(pair, index): return (pair[int(index)], pair[1-int(index)])

def GramGramDirection_InspectionHTML(gram1, gram2, direction):
   html = Aggregator()
   for gram1_equiv, gram2_equiv in product(sorted(gram1.Equivalents()), sorted(gram2.Equivalents())):
      mentioner_lists = _GramGram_Mentionerlists(gram1_equiv, gram2_equiv, 'global')
      html << _GramGramDirectionMentionerlists_Inspection(gram1_equiv, gram2_equiv, direction, mentioner_lists)
   
   for thing in gram1, gram2:
      thing_equivs = sorted(thing.Equivalents())
      html << Paragraph(f"equivalence class of {Gram_Element(thing, info={'kind':'inspection'})}: {{{', '.join(Gram_Element(thing_equiv, info={'kind':'inspection'}) for thing_equiv in thing_equivs)}}}")
      for thing1, thing2 in combinations(thing_equivs, 2): # maybe reorder so lang order inversions go first
         equiv_mentioner_lists = _GramGram_Mentionerlists(thing1, thing2, 'global')
         if len(equiv_mentioner_lists['pastward']) + len(equiv_mentioner_lists['futureward']) > 0:
            for thing_direction in G_Directions:
               html << _GramGramDirectionMentionerlists_Inspection(thing1, thing2, thing_direction, equiv_mentioner_lists)
   return html() if html.has_any else Paragraph(f"(unknown why {Gram_Element(gram1, info={'kind':'inspection'})} points {direction} to {Gram_Element(gram2, info={'kind':'inspection'})}")

def _GramGramDirectionMentionerlists_Inspection(gram1, gram2, direction, mentioner_lists):
   html = Aggregator()
   for i,this_direction in enumerate([direction, Direction_Reversed(direction)]):
      if len(mentioner_lists[this_direction])>0:
         this_given_pair = _SWAP((gram1, gram2), i)
         this_past_future_pair = _SWAP(this_given_pair, this_direction == 'futureward')

         result_rows = set()
         for source_word in sorted(mentioner_lists[this_direction]):
            for inference in Word_Inferences(source_word):
               if this_past_future_pair in Reflinks_Gramlinks(inference['reflinks']):
                  header_text = Tokens_Text(inference['header tokens'])
                  match_text = Tokens_Text(inference['match_tokens'])
                  new_match_text = match_text
                  for token in inference['match_tokens']:
                     if token['kind'] == 'template':
                        if not Ref_Grams(token['content']).isdisjoint(set(this_given_pair)):
                           token_text = token['content']['text']
                           new_match_text = new_match_text.replace(token_text, Color((160,190,255), token_text))
                  text = header_text.replace(match_text, Color((255,90,90), new_match_text))
                  result_rows.add((source_word, inference['header'], inference['name'], text))

         if len(result_rows) > 0:
            html << f"sources saying {Gram_Element(this_given_pair[0], info={'kind':'inspection'})} points {direction} to {Gram_Element(this_given_pair[1], info={'kind':'inspection'})}:<br>"
            html << Tuples_HTMLtable((Word_Element(word, info={'kind':'inspection'}),
                         Color((130,225,255), header), name, text) for word, header, name, text in sorted(result_rows))
   return html()

# following NOT TO BE USED internally, because e.g. what if the gram in quesiton is 'adding'


