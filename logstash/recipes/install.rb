
package "openjdk-6-jdk"

directory "/opt/logstash" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end
directory "/opt/logstash/logstash.conf" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

remote_file "/opt/logstash/logstash-monolithic.jar" do
  source "http://logstash.objects.dreamhost.com/release/logstash-1.1.9-monolithic.jar"
end

cookbook_file "/opt/logstash/logstash.conf/full.conf" do
  source "config/full.conf"
  mode "0700"
end

cookbook_file "/etc/init.d/logstash" do
  source "init.d/logstash.sh"
  mode "0700"
end

execute "logstash: update run level" do
  command "sudo update-rc.d logstash defaults"
end
