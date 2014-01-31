

directory "/opt/kibana" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

remote_file "/opt/kibana/kibana.tar.gz" do
  source "https://github.com/rashidkpc/Kibana/archive/v0.2.0.tar.gz"
end

execute "logstash/kibana: unpack" do
  cwd "/opt/kibana/"
  command "tar -xzf kibana.tar.gz"
end

cookbook_file "/opt/kibana/Kibana-0.2.0/KibanaConfig.rb" do
  source "kibana/KibanaConfig.rb"
  mode "0644"
end

execute "logstash/kibana: gem install bundler" do
  command "sudo gem install bundler"
end

execute "logstash/kibana: bundle install" do
  cwd "/opt/kibana/Kibana-0.2.0"
  command "bundle install"
end


cookbook_file "/etc/init.d/kibana" do
  source "init.d/kibana.sh"
  owner "root"
  group "root"
  mode "0755"
end

execute "logstash/kibana: update run level" do
  command "update-rc.d kibana defaults"
end


