name 'base'
description 'Base role for all nodes'

# This role has no run list as it is included for its attributes in
# the OS specific roles (mac_os_x or ubuntu) that I use.

# Override attributes are used because this is a nested role and
# precedence may be confusing in some setups.
override_attributes(
  'authorization' => {
    'sudo' => {
      'groups' => ['admin', 'wheel'],
      'users' => ['USERNAME'],
      'passwordless' => true } } )
