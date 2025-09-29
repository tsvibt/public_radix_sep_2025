from src.radix import *
import time 
import os
import builtins

Log.__init__('precompute')
mprint.printing_on = False

#my_profile calls cProfile.run, which uses the __main__ namespace... which is pre/a_.. etc.
ABSTRACTED_HELPER = {} 
def CALL(to_dos, to_profile=(not globals().get('G_Server_mode', False))): 
   ABSTRACTED_HELPER['call'] = lambda: CALLED(to_dos)
   if not to_profile:
      ABSTRACTED_HELPER['call']()
   else:
      my_profile("ABSTRACTED_HELPER['call']()", log_file=Log.file(), log_string='targeting ' + ', '.join(table.name for to_do in to_dos for table in to_do['target tables']) + ', run on Wiktionary db: ' + str(Wiktionary.db_dir))

def OBJECT_TABLE_TODO(obj, table, dict_single_value=False):
   match obj:
      case dict() if not dict_single_value : generator_source = obj       ; function = lambda x,y: [(x,y)]
      case _                               : generator_source = [(obj, )] ; function = lambda x: [(ONE_KEY, x,)]
   return {'generator source':generator_source, 'function':function, 'target tables':[table], 'message': 'writing '}

def CALLED(to_dos):
   for to_do in to_dos: TODO_EXECUTE(to_do)
   GLOBALCACHES.wipe_all()

def TODO_EXECUTE(to_do):
   items_count, generator = make_generator(to_do['generator source'], to_do.get('batchsize', 30000))
   printing_items_count = min(items_count, to_do.get('limit', items_count + 5))
   limit_items_count = to_do.get('limit', items_count * 2)
   [table.Drop() for table in to_do['target tables']]

   start_time = time.time()
   for current_row_index,item in enumerate(generator):
      if current_row_index%1000==0: GLOBALCACHES.ensure_below_ceiling()
      maybe_print_status(current_row_index, printing_items_count, to_do, start_time, item)
      do_over_item(item, to_do)
      if current_row_index > limit_items_count: break

   [table.Execute_all_updates() for table in to_do['target tables']]


def make_generator(generator_source, batchsize):
   match generator_source:
      case Disk_Table() as table:
#         def generator():
#            key_batches = table.KeyBatchGenerator(batchsize)
#            while (keys := next(key_batches)):
#               for key in keys: yield [*key, table.Get(key)]
         return (table.Count(), table.RowIterator())
#         return (table.Count(), generator())

      case tuple(): return generator_source
      case set()  : return (len(generator_source), map(lambda x: (x,), generator_source))
      case dict() : return (len(generator_source), generator_source.items())
      case _      : return (len(generator_source), generator_source)

def do_over_item(args, to_do, ):
   RESULTS = to_do['function'](*args) # we want to run the function, whether or not we're writing anything
   match to_do['target tables']:
      case []             : pass
      case [target_table] : [target_table.Row_QueuePair(result)  for result in RESULTS]
      case _              : [result[0].Row_QueuePair(result[1:]) for result in RESULTS]

def maybe_print_status(current_row_index, items_count, to_do, start_time, args):
   if to_do.get('printing', True) and current_row_index%globals().get('G_PRINT_frequency', 10) == 0:
      timestamp = time.time()
      hours_taken = (timestamp - start_time)/3600
      fraction_done = max(current_row_index / items_count, 1/10000000000)
      print(f'''\n{to_do.get('message', '')}{','.join(table.name.split('_')[-1] for table in to_do['target tables'])}. {current_row_index} of {items_count}; {round(100*fraction_done, 1)}%; {"{:.2f}".format(hours_taken)}h, ~{"{:.2f}".format((1-fraction_done)*hours_taken/fraction_done)}h left; {current_MBs_RAM()}MB. ''',  end='')
   if to_do.get('printing_args', True) and not globals().get('G_Server_mode', False):
      match type(args[0]):
         case str()  : print(args[0]      , end=' ')
         case Gram() : print(args[0].text , end=' ')


