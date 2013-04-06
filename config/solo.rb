root = File.expand_path('../..', __FILE__)

file_cache_path  "#{root}/.chef/cache"
file_backup_path "#{root}/.chef/backup"
cache_options path: "#{root}/.chef/checksums", skip_expires: true

role_path "#{root}/roles"

cookbook_path [
  "#{root}/cookbooks",
  "#{root}/site_cookbooks" ]

data_bag_path "#{root}/data_bags"
