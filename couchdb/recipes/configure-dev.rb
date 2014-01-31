

file "/usr/local/etc/couchdb/local.d/dev.ini" do
  owner "couchdb"
  group "couchdb"
  mode "0755"
  action :create
  content '

[httpd]
bind_address = 0.0.0.0

'
end
