from src.shared_state import DB
from src.utilities import * 
#from src.languagecodes import * 

from dataclasses import dataclass, field
from functools import total_ordering


def Gramtitle_Gramtext(gramtitle): return ('*' if len(segments := gramtitle.split('/'))>1 else '') + segments[-1]

@total_ordering
@dataclass(frozen=True)
class Gram:
   text : str
   lang : str

   def __repr__(self)     : return f'[{self.text}, {self.lang}]'
   def __lt__(self, gram) : 
      return ((Lang_age(self.lang), self.lang, gram.text)
            > (Lang_age(gram.lang), gram.lang, self.text))
   def __iter__(self): yield self.text; yield self.lang

   def Gramtitle(self): return self.text if self.text[:1] != '*' else f'Reconstruction:{DB._CodeLangs.OneValue()[self.lang]}/{self.text[1:]}'
   # RETRIEVAL methods to get from DB

   def Parsed             (self): return gramdict   if (gramdict   := DB._GRAM_Parsed            .CACHE_Get(self)) else {}
   def AllMentioningGrams (self): return mentioners if (mentioners := DB._GRAM_AllMentioningGrams.CACHE_Get(self)) else set()
   def AllRealGivenWords  (self): return result     if (result     := DB._GRAM_RealGivenWords    .CACHE_Get(self)) else set()
   def GivensOrPlaceholder(self): return givens     if (givens     := self.AllRealGivenWords()) else {Word(self, -1)}
   def Equivalents        (self): return DB._GRAM_Equivalents.Get(self)

   def Direction_Givenrefgrams(self, direction): return DB._GRAM_Direction_GivenRefGrams.CACHE_Get(self, direction)
   def Direction_Immediates(self, direction):
      match direction:
         case 'pastward'   : return DB._GRAM_ImmediatePastwards  .CACHE_Get(self)
         case 'futureward' : return DB._GRAM_ImmediateFuturewards.CACHE_Get(self)
   def Direction_Stricts(self, direction):
      match direction:
         case 'pastward'   : return DB._GRAM_StrictPastwards.  Get(self)
         case 'futureward' : return DB._GRAM_StrictFuturewards.Get(self)


@dataclass(frozen=True, order=True)
class Word:
   gram : Gram
   num  : int
   def __init__(self, *args):
      match args:
         case text, lang, num : object.__setattr__(self, 'num', num) ; object.__setattr__(self, 'gram', Gram(text, lang))
         case gram, num       : object.__setattr__(self, 'num', num) ; object.__setattr__(self, 'gram', gram)

   @property
   def lang(self): return self.gram.lang
   @property
   def text(self): return self.gram.text

   def __repr__(self): return f'{self.gram}_{self.num}'
   def __iter__(self): yield from self.gram; yield str(self.num) # will join strings as db key

   # RETRIEVAL methods to get from DB
   def FutureGramlinks(self)   : return links if (links := DB._WORD_OwnFuturewardGramlinks.Get(self)) else []
   def Parsed(self)            : return {} if self.num==-1 else self.gram.Parsed()[self.num]
   def PastwardWordposet(self) : return DB._WORD_PastwardPoset.Get(self)
   def Direction_Gramrefs(self, direction):
      if self.num == -1: return set()
      else             : return gramrefs if (gramrefs := DB._WORD_Direction_OwnRefGrams.CACHE_Get(self, direction)) else set()

def str_Gram(s):
   s=s.split('exploring')[-1].split('adding')[-1].split('futureward')[0].split('pastward')[0].strip(' []_1234567890')
   gramtext, lang = s.split(',')
   return Gram(gramtext.strip(' '), lang.strip(' '))

def str_Word(s):
   gramtext, lang = s.split('exploring')[-1].split('adding')[-1].strip(' []-_1234567890').split(', ')
   return Word(Gram(gramtext, lang), int(s.strip().split('_')[-1]))

def Lang_age(lang_code): return DB._LangAge.OneValue().get(lang_code, 0)

