include_recipe "helper::package_update"

package "nginx"


file "/etc/nginx/sites-enabled/munin" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content '
server {
       listen 8081;
       root /var/cache/munin/www/;
       index index.html index.htm;

       location / {
               try_files $uri $uri/ =404;
       }
}


'
end


directory "/srv/www/" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
  recursive true
end

directory "/srv/www/media/" do
  owner "vagrant"
  group "vagrant"
  mode "0777"
  action :create
  recursive true
end

file "/etc/nginx/sites-enabled/web" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content '
server {
  listen 8082;
  root /srv/www/;
  index	   index.php;
  server_name	workplace1.local.dev;
  location / {
    index index.html index.php;
    try_files $uri $uri/ @handler;
    expires 30d;
  }
  location ~ ^/(app|includes|lib|media/downloadable|pkginfo|report/config.xml|var)/ { internal; }
  location /var/export/ { internal; }
  location /. { return 404; }
  location @handler { rewrite / /index.php; }
  location ~* .php/ { rewrite ^(.*.php)/ $1 last; }
  location ~* .php$ {
    if (!-e $request_filename) { rewrite / /index.php last; }
    expires off;
    fastcgi_pass 127.0.0.1:9001;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param MAGE_RUN_CODE default;
    fastcgi_param MAGE_RUN_TYPE store;
    include fastcgi_params;
  }
}

'
end
