'''
exec(open('scripts/test_script.py').read())
exec(open('src/page/server.py').read())
'''

import os
def list_files_recursively(directory='.'):
    files_list = []
    for dirpath, dirnames, filenames in os.walk(directory):
        for filename in filenames:
            files_list.append(os.path.join(dirpath, filename))
    return files_list


RadixRootdir = os.getcwd().split('radix')[0] + 'radix/'
SnapshotsDir = RadixRootdir + 'snapshots/'

snapshot_files = list_files_recursively(SnapshotsDir)

import subprocess

import webbrowser

def open_in_chrome(url):
   webbrowser.get('chrome').open(url)


for snapshot_file in snapshot_files:
   wordtext = snapshot_file.split('/')[-1].split('_')[0]
   if wordtext != '.DS':
      server_url = 'http://localhost/word/'+wordtext
      open_in_chrome(server_url)
      open_in_chrome('file://' + snapshot_file)


