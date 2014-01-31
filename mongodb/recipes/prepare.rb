
#http://docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/
execute "mongoDB prepare: add keyserver" do
  command "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
end


file "/etc/apt/sources.list.d/10gen.list" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  content 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen'
end


execute "mongoDB prepare: update packagemanager state" do
  command "sudo apt-get update"
end

