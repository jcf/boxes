begin
  box = data_bag_item('apps', 'box')
  user = data_bag_item('users', Etc.getlogin)
rescue Net::HTTPServerException => e
  Chef::Application.fatal!("#{cookbook_name} could not load data bag; #{e}")
end

def each(hash, key)
  if (list = hash[key])
    list.each { |x| yield x }
  end
end

each(box, 'packages') do |p, o|
  package p do
    action :install
    options o if o && o.length > 0
  end
end

each(box, 'dirs') do |dir|
  directory "#{ENV['HOME']}/#{dir}" do
    recursive true
  end
end

each(user, 'repos') do |target, repo|
  git "#{ENV['HOME']}/#{target}" do
    repository repo['repo']
    reference repo['revision']
    action :sync
    user user['id']
  end
end

case node['platform']
when 'mac_os_x'
  directory "#{ENV['HOME']}/Applications"

  execute 'killall Dock' do
    action :nothing
  end

  each(box, 'plists') { |plist| mac_os_x_plist_file plist }

  each(box, 'dmgs') do |pkg, data|
    dmg_package pkg do
      app data['app'] if data.has_key?('app')
      volumes_dir data['volumes_dir'] if data.has_key?('volumes_dir')
      dmg_name data['dmg_name'] if data.has_key?('dmg_name')
      destination data['destination'] if data.has_key?('destination')
      type data['type'] if data.has_key?('type')
      source data['url']
      checksum data['checksum']
    end
  end
end
