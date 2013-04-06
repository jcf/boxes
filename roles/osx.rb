name 'osx'
description 'Role applied to all OS X systems'

run_list(
  'role[base]',
  'recipe[build-essential]',
  'recipe[homebrew]' )
