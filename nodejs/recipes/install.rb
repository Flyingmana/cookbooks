


file "/etc/apt/sources.list.d/nodejs.list" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content '
deb http://http.us.debian.org/debian wheezy-backports main

'
end


execute "apt-get update" do
  command "apt-get update"
end

execute "apt-get install nodejs" do
  command "apt-get -y -t wheezy-backports install nodejs"
end

execute "apt-get install nodejs-legacy" do
  command "apt-get -y -t wheezy-backports install nodejs-legacy"
end


#remote_file "/tmp/npmjs.install.sh" do
#  source "https://www.npmjs.org/install.sh"
#end

execute "curl install npm" do
  command "curl https://www.npmjs.org/install.sh | sudo clean=no sh"
end

execute "curl install phantomjs" do
  command "npm install -g phantomjs"
end

execute "curl install casperjs" do
  command "npm install -g casperjs"
end




