
import os 
RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'

WiktionariesDir = RadixRootdir + 'wiktionaries/'
ResourcesDir    = RadixRootdir + 'resources/'
SourceDir       = RadixRootdir + 'src/'
LogDir          = RadixRootdir + 'log/'
SiteDir  = SourceDir + 'site/'
PagesDir = SourceDir + 'pages/'

G_Cached_Coglangs = {'la', 'grc',  'en', 'de', 'sa', 'ru'}
#G_Cached_Coglangs = {'xto', 'txb', 'sq', 'hit', 'hy', 'lt', 'lv', 'ru', 'uk', 'pl', 'sh', 'ga', 'grc', 'el', 'la', 'es', 'it', 'fr', 'pt', 'de', 'nl', 'en', 'nb', 'sv', 'is', 'fa', 'hi',  }
G_Default_Coglangs = {'la', 'grc',  'en', 'de'}
G_Endlangs = ['en', 'de',]
G_print_summary_langs = ['en', 'de',]


