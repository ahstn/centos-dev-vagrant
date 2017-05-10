default['sublime']['url'] = 'https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2'
default['sublime']['dir'] = '/opt/sublime_text_3'
default['sublime']['path'] = '/usr/bin/subl'
default['sublime']['archive'] = '/tmp/sublime_text.tar.bz2'

default['sublime']['pc']['url'] = 'https://packagecontrol.io/Package%20Control.sublime-package'
default['sublime']['pc']['dir'] = File.join(
  node['vagrant']['home'],
  '.config/sublime-text-3/Installed Packages'
)
default['sublime']['pc']['path'] = File.join(
  node['sublime']['pc']['dir'],
  'Package Control.sublime-package'
)
