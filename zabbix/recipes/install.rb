
package "libsnmp-dev"
package "snmp"

remote_file "/tmp/zabbix-#{node["zabbix"][:version]}.tgz" do
  source "http://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/#{node["zabbix"][:version]}/zabbix-#{node["zabbix"][:version]}.tar.gz/download"
end

execute "zabbix: unpack" do
  command "cd /tmp && tar -xzf zabbix-#{node["zabbix"][:version]}.tgz"
end

group "zabbix" do
end

user "zabbix" do
  comment "zabbix user"
  gid "zabbix"
  home "/usr/local/var/zabbix"
  shell "/bin/bash"
  system true
end

execute "zabbix: ./configure" do
  cwd "/tmp/zabbix-#{node["zabbix"][:version]}"
  environment "HOME" => "/root"
  command "./configure --prefix=/usr/local --enable-server --enable-agent --with-mysql --enable-ipv6 --with-net-snmp --with-libcurl --with-ssh2"
end

execute "zabbix: make, make install" do
  cwd "/tmp/zabbix-#{node["zabbix"][:version]}"
  environment "HOME" => "/root"
  command "make install"
end


