
from src.ordering import *
from src.classes import *
from src.inference.inference import *


def GramposetGramwords_Includedwords(poset, starting_included_words):
   ClusionGram_Words = {'included':{}, 'excluded':{}}
   def gram_includewords_update(gram, words):
      ClusionGram_Words['included'][gram] = words
      ClusionGram_Words['excluded'][gram] = gram.GivensOrPlaceholder() - words

# note that this is maybe not super correct.... it doesn't account that there could be collisions, where a word that is not in the past of a gram sitll covers that gram and is still in some same poset...
   def gram_explicitly_covered_by(gram, clusion):
      return any(covering_word in ClusionGram_Words[clusion].get(covering_word.gram, set()) for covering_word in DB._GRAM_Direction_Coveringwords.CACHE_Get(gram, poset.direction))

   def gram_directly_covered_by(gram, clusion):
      return any(gram in word.Direction_Gramrefs(poset.direction)
            for _, words in ClusionGram_Words[clusion].items() for word in words)

   def word_is_backlinking(word):
      try:
         return any(len(ClusionGram_Words['included'].get(target_gram, set())) > 0 
            for target_gram in word.Direction_Gramrefs(Direction_Reversed(poset.direction)))
      except:
         message = f'word_is_backlinking failed on word {word} where word.gram.AllRealGivenWords() is {word.gram.AllRealGivenWords()}'
         Log(message)
         mprint(message)
         return False

   for gram in poset.domain:
      if gram in starting_included_words:
         gram_includewords_update(gram, starting_included_words[gram])
      elif all(len(ClusionGram_Words['included'][prior_gram])==0 for prior_gram in poset.immediate_priors[gram]):
         gram_includewords_update(gram, set())
      elif (not gram_explicitly_covered_by(gram, 'included')) and gram_explicitly_covered_by(gram, 'excluded'):
         gram_includewords_update(gram, set())
      #experiminental :
#      elif (not gram_directly_covered_by(gram, 'included')) and gram_directly_covered_by(gram, 'excluded'):
#         gram_includewords_update(gram, set())

#      elif all the reasons saying that this gram is here... wait do we mean direct reasons, or all reasons including skips..??? have been excluded...... o r, if any link from a word to this gram...
      else:
         backlinking_words = set(filter(word_is_backlinking, gram.AllRealGivenWords()))
         gram_includewords_update(gram, gram.GivensOrPlaceholder() if len(backlinking_words) == 0 else backlinking_words)

   return ClusionGram_Words['included']

def WordPoset_Wordposet(word, poset):
   includedWords = GramposetGramwords_Includedwords(poset, {word.gram:{word}})
   return Wordposet((poset, includedWords), kind='from_poset')

def GramPoset_Ulteriorsubposet(gram, poset):
   return PosetCloseddomain_Restricted(poset, poset.strictself_ulteriors(gram))

def Gram_Pastwardposet(gram) : return GramDirection_ManualPoset(gram, 'pastward')
def Gram_Futureposet(gram)   : return GramDirection_ManualPoset(gram, 'futureward')

def GramDirection_ManualPoset(main_gram, direction):
#   domain_set = main_gram.Direction_Stricts(direction) | DB._GRAM_Equivalents.CACHE_Get(main_gram) 
   domain_set = main_gram.Direction_Stricts(direction) | {main_gram} 
   all_attributes = {
      'direction': direction, 
      'item_equivalents':{gram:DB._GRAM_Equivalents.CACHE_Get(gram) for gram in domain_set}, 
      'immediate_ulteriors':{gram:gram.Direction_Immediates(direction) for gram in domain_set}, 
      'immediate_priors':{gram:gram.Direction_Immediates(Direction_Reversed(direction)) & domain_set for gram in domain_set}, 
      'strict_ulteriors':{gram:gram.Direction_Stricts(direction) for gram in domain_set}}
   all_attributes['domain'] = ImmediateulteriorsImmediatepriors_Sorted(all_attributes['immediate_ulteriors'], all_attributes['immediate_priors'])
   return Poset(all_attributes, manual=True)

def PosetLang_Subposet(poset, lang):
   return PosetDomain_Restricted(poset, 
      filter(lambda gram: any(u_gram.lang == lang for u_gram in poset.strictself_ulteriors(gram)), poset.domain))

def PosetLangIncludedwords_Subwordposet(gramposet, lang, includedWords):
   subposet = PosetLang_Subposet(gramposet, lang)
   restricted_includedWords = {gram:words for gram, words in includedWords.items() if gram in subposet.immediate_ulteriors}
   return Wordposet((subposet, restricted_includedWords), kind='from_poset')



###### for asych

