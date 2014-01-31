include_recipe "couchdb::prepare"

remote_file "/tmp/apache-couchdb-#{node["couchdb"][:version]}.tgz" do
  source "http://apache.openmirror.de/couchdb/source/#{node["couchdb"][:version]}/apache-couchdb-#{node["couchdb"][:version]}.tar.gz"
  #checksum node["couchdb"][:checksum]
end

execute "couchDB: unpack" do
  command "cd /tmp && tar -xzf apache-couchdb-#{node["couchdb"][:version]}.tgz"
end

  
execute "couchDB: ./configure" do
  cwd "/tmp/apache-couchdb-#{node["couchdb"][:version]}"
  environment "HOME" => "/root"
  command "./configure"
end


execute "couchDB: make, make install" do
  cwd "/tmp/apache-couchdb-#{node["couchdb"][:version]}"
  environment "HOME" => "/root"
  command "make && make install"
end

group "couchdb" do
end

user "couchdb" do
  comment "CouchDB Administrator"
  gid "couchdb"
  home "/usr/local/var/lib/couchdb"
  shell "/bin/bash"
  system true
end


script "couchDB: permissions" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
	chown -R couchdb:couchdb /usr/local/var/log/couchdb
	chown -R couchdb:couchdb /usr/local/var/lib/couchdb
	chown -R couchdb:couchdb /usr/local/var/run/couchdb
  EOH
end


execute "couchDB: link init.d" do
  command "ln -sf /usr/local/etc/init.d/couchdb  /etc/init.d"
end


execute "yaws: update run level" do
  command "update-rc.d couchdb defaults"
end
