begin
  box = data_bag_item('apps', 'box')
  user = data_bag_item('users', Etc.getlogin)
rescue Net::HTTPServerException => e
  Chef::Application.fatal!("#{cookbook_name} could not load data bag; #{e}")
end

if use_brew?
  box['brew_packages'].each do |p, o|
    package p do
      action :install
      options o if o && o.length > 0
    end
  end
else
  box['packages'].each do |p,o|
    package p do
      action :install
    end
  end
end

box['dirs'].each do |dir|
  directory "#{ENV['HOME']}/#{dir}" do
    recursive true
  end
end

if user.has_key?('repos')
  user['repos'].each do |target, repo|
    git "#{ENV['HOME']}/#{target}" do
      repository repo['repo']
      reference repo['revision']
      action :sync
      user user['id']
    end
  end
end

case node['platform']
when 'mac_os_x'
  directory "#{ENV['HOME']}/Applications"

  execute 'killall Dock' do
    action :nothing
  end

  box['plists'].each do |plist|
    mac_os_x_plist_file plist
  end

  box['dmgs'].each do |pkg, data|
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
