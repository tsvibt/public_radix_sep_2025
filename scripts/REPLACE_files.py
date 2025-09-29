'''
python ../../scripts/REPLACE_files.py
'''

import os

def replace_string_in_files(directory, s1, s2):
   for root, _, files in os.walk(directory):
      for file in files:
         print(file)
         filepath = os.path.join(root, file)
         if not any(x in filepath for x in ['backups-nvim', '__pycache__', 'DS_Store', 'page/']):
            with open(filepath, 'r') as f:
               content = f.read()
            content = content.replace(s1, s2)
            with open(filepath, 'w') as f:
               f.write(content)

replacements = [


('N_GI_word_coverings', 'N_QGI_word_coverings')
]

for s1,s2 in replacements:
   replace_string_in_files('./', s1, s2)
   os.rename(s1+'.py', s2+'.py')



'''





('I_G_word_all_futures', 'I_G_word_strictfutures')



('0_xmldump_redirects', 'A_xmldump_redirects'),
('1_xmldump_separate', 'B_xmldump_separate'),
('2_xmls_parse', 'C_AB_xmls_parse'),
('parsed_allmentioners', 'D_C_parsed_allmentioners'),
('3_parse_linksrefs', 'E_C_parse_linksrefs'),
('4_linksrefs_pastwardsfuturewards', 'F_E_linksrefs_pastwardsfuturewards'),
('5_wordpastmosts', 'G_F_wordpastmosts'),
('5_5_word_immediatefutures', 'H_G_word_immediatefutures'),
('5_6_word_all_futures', 'I_G_word_all_futures'),
('6_pastmost_futureposet', 'J_G_pastmost_futureposet'),
('7_parsed_realgivensenses', 'K_C_parsed_realgivensenses'),
('word_allfutures', 'L_J_word_strictfutures'),
('word_lang_futures', 'M_L_word_lang_allfutures'),
('word_coverings', 'N_IJ_word_coverings'),
('sense_pastwardsenseposet', 'O_KN_sense_pastwardsenseposet'),
('pastmostsense_futuresenseposet', 'P_O_pastmostsense_futuresenseposet'),


'''
