include_recipe "couchdb::prepare"

remote_file "/tmp/couchdb-#{node["couchdb"][:version]}.tgz" do
  source "http://www.apache.org/dist/couchdb/#{node["couchdb"][:version]}/apache-couchdb-#{node["couchdb"][:version]}.tar.gz"
  checksum node["couchdb"][:checksum]
end

execute "couchDB: unpack" do
  command "cd /tmp && tar -xzf couchdb-#{node["couchdb"][:version]}.tgz"
end

  
execute "couchDB: ./configure" do
  cwd "/tmp/couchdb-#{node["couchdb"][:version]}"
  environment "HOME" => "/root"
  command "./configure"
end


execute "couchDB: make, make install" do
  cwd "/tmp/couchdb-#{node["couchdb"][:version]}"
  environment "HOME" => "/root"
  command "make && make install"
end

user "couchdb" do
  comment "CouchDB Administrato"
  gid "couchdb"
  home "/usr/local/var/lib/couchdb"
  shell "/bin/bash"
  system true
end
