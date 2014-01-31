include_recipe "mysql::prepare"

# 64bit
# http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.10-debian6.0-x86_64.deb/from/http://cdn.mysql.com/
# 32bit
# http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.10-debian6.0-i686.deb/from/http://cdn.mysql.com/
remote_file "/tmp/mysql-#{node["mysql"][:version]}.deb" do
  #source "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.13-debian6.0-x86_64.deb/from/http://cdn.mysql.com/"
  source "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.13-debian6.0-i686.deb/from/http://cdn.mysql.com/"
end


group "mysql" do
end

user "mysql" do
  comment "mysql Administrator"
  gid "mysql"
  home "/usr/local/var/lib/mysql"
  shell "/bin/bash"
  system true
end


directory "/usr/local/var/log/mysql" do
  owner "mysql"
  group "mysql"
  mode "0755"
  action :create
  recursive true
end
directory "/usr/local/var/lib/mysql" do
  owner "mysql"
  group "mysql"
  mode "0755"
  action :create
  recursive true
end
directory "/usr/local/var/run/mysqld" do
  owner "mysql"
  group "mysql"
  mode "0755"
  action :create
  recursive true
end


execute "MySql: install" do
  command "sudo dpkg -i /tmp/mysql-#{node["mysql"][:version]}.deb"
end



execute "MySql: link executables" do
  #command "ln -sf /opt/mysql/server-5.6/bin/* /usr/local/bin/"
  command "ln -sf /opt/mysql/server-5.6/bin/* /usr/bin/"
end

=begin
template "/etc/init.d/mysql" do
  source "init.d/mysql.erb"
  mode 0744
  owner "root"
  group "root"
  variables(
  )
end
=end


execute "MySql: link init.d" do
  command "ln -sf /opt/mysql/server-5.6/support-files/mysql.server /etc/init.d/mysql"
end


directory "/etc/mysql/conf.d" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  recursive true
end

template "/etc/my.cnf" do
  source "my.cnf"
  mode 0644
  owner "root"
  group "root"
  variables(
  )
end


execute "MySql: update run level" do
  command "update-rc.d mysql defaults"
end

execute "MySql: stop currently running instances" do
  command "/etc/init.d/mysql stop"
end

execute "MySql: setup" do
  command "./support-files/binary-configure"
  cwd "/opt/mysql/server-5.6"
end
execute "MySql: setup dbs" do
  command "./scripts/mysql_install_db --verbose --user=mysql --datadir=/usr/local/var/lib/mysql"
  cwd "/opt/mysql/server-5.6"
end
#execute "MySql: securing" do
#  command "./bin/mysql_secure_installation"
#  cwd "/opt/mysql/server-5.6"
#end

execute "MySql: link libmysqlclient.so" do
  command "ln -s /opt/mysql/server-5.6/lib/libmysqlclient.so.18 /usr/local/lib/libmysqlclient.so.18"
end

execute "MySql: ldconfig" do
  command "ldconfig"
end


