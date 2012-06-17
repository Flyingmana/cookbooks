include_recipe "yaws::prepare"

remote_file "/tmp/yaws-#{node["yaws"][:version]}.tgz" do
  source "http://yaws.hyber.org/download/yaws-#{node["yaws"][:version]}.tar.gz"
  checksum node["yaws"][:checksum]
end

execute "yaws: unpack" do
  command "cd /tmp && tar -xzf yaws-#{node["yaws"][:version]}.tgz"
end

  
execute "yaws: ./configure" do
  cwd "/tmp/yaws-#{node["yaws"][:version]}"
  environment "HOME" => "/root"
  command "./configure --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var"
end


execute "yaws: make, make install" do
  cwd "/tmp/yaws-#{node["yaws"][:version]}"
  environment "HOME" => "/root"
  command "make && make install"
end

group "www-data" do
end

user "www-data" do
  comment "Yaws Administrator"
  gid "www-data"
  home "/usr/local/var/yaws"
  shell "/bin/bash"
  system true
end



cookbook_file "/tmp/yaws_404_to_index_php.erl" do
  source "yaws_404_to_index_php.erl" 
  mode "0644"
end

execute "yaws: compile 404 redirect module" do
  cwd "/usr/local/lib"
  command "sudo erlc -o /var/yaws/ebin  /tmp/yaws_404_to_index_php.erl"
end

directory "/usr/local/var/yaws/www_default" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

cookbook_file "/usr/local/var/yaws/www_default/index.html" do
  source "www_default.html" 
  mode "0644"
end
cookbook_file "/usr/local/var/yaws/www_default/index.php" do
  source "www_default.php" 
  mode "0644"
end



script "yaws: permissions" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  mkdir /usr/local/var/lib/www-data
	chown -R www-data:www-data /usr/local/var/lib/www-data
	chown -R www-data:www-data /usr/local/var/yaws
	chown -R www-data:www-data /var/yaws 
	chown -R www-data:www-data /var/log/yaws/
	chown -R www-data:www-data /usr/local/lib/yaws
  EOH
end




template "/etc/yaws/yaws.conf" do
  source "yaws.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
  )
end


file "/etc/init.d/yaws" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  content '#! /bin/sh
# /etc/init.d/yaws
#

# Some things that run always
# touch /var/lock/blah

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting yaws "
    cd /usr/local/var/yaws
    YAWSHOME=/usr/local/var/yaws privbind -u www-data /usr/local/bin/yaws --daemon --heart
    ;;
  stop)
    echo "Stopping yaws"
    YAWSHOME=/usr/local/var/yaws /usr/local/bin/yaws --stop
    ;;
  *)
    echo "Usage: /etc/init.d/yaws {start|stop}"
    exit 1
    ;;
esac

exit 0'
end

execute "yaws: update run level" do
  command "update-rc.d yaws defaults"
end





