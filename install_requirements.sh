#!/bin/sh

sudo apt-get install ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert curl

cd /tmp
curl -O http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
tar zxf rubygems-1.8.10.tgz
cd rubygems-1.8.10
sudo ruby setup.rb --no-format-executable

sudo gem install chef --no-ri --no-rdoc
sudo gem install ohai

sudo ln -s /var/lib/gems/1.8/bin/chef-solo /usr/bin/chef-solo

sudo mkdir -p /etc/chef
sudo echo 'file_cache_path "/tmp/chef-solo" \n cookbook_path "/tmp/chef-solo/cookbooks"' > /etc/chef/solo.rb

#/etc/chef/solo.rb
#file_cache_path "/tmp/chef-solo"
#cookbook_path "/var/chef-solo/cookbooks"

#chef-solo -j /var/chef-solo/cookbooks/install.json