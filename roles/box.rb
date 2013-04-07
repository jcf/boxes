name 'box'
description 'A box'

run_list(
  'recipe[build-essential]',
  # 'recipe[ruby_build]',
  # 'recipe[rbenv::user]',
  # 'recipe[users]',
  'recipe[box]')
  # 'recipe[mac_os_x::settings]',
  # 'recipe[mac_os_x::firewall]',

  # 'recipe[iterm2]',
  # 'recipe[virtualbox]',
  # 'recipe[ghmac]',
  # 'recipe[1password]')
