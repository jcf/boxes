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
      'users' => ['jcf'],
      'passwordless' => true } },

  'rbenv' => {
    'install_pkgs' => [],
    # The version of Ruby should match across all of rubies, global,
    # and the keys of the gems hash.
    'user_installs' => [
      { 'user' => 'jcf',
        'rubies' => ['1.9.3-p194', 'jruby-1.7.3'],
        'global' => '1.9.3-p194' } ]})
