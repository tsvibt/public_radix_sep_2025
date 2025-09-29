
from src.precomputing.coordinator import *

def PIE_path(suffix): return f'{ResourcesDir}proto-indo-european-langs{suffix}.txt'

includeLangNames = {sline for line in Read(PIE_path('')).split('\n') if (sline := line.strip())}

PIE_langcode_poset = Poset(ast.literal_eval(Read(PIE_path('-tree'))))

to_do_1 = OBJECT_TABLE_TODO(includeLangNames, DB._IncludeLangnames)
to_do_2 = OBJECT_TABLE_TODO(PIE_langcode_poset, DB._PIElangposet)

CALL([to_do_1, to_do_2, ])


