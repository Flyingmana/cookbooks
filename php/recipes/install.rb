include_recipe "php::prepare"

# seems to add an \n
php_installed_version = `which php >> /dev/null && php -v|grep #{node["php"][:version]}|awk '{ print substr($2,1,5) }'`

php_already_installed = (php_installed_version != "")


if !node["php"][:reinstall] && php_already_installed
  Chef::Log.info('php was already installed')
  return
end

remote_file "/tmp/php-#{node["php"][:version]}.tgz" do
  source "http://www.php.net/get/php-#{node["php"][:version]}.tar.gz/from/www.php.net/mirror"
  #checksum node["php"][:checksum]
end

execute "PHP: unpack" do
  command "cd /tmp && tar -xzf php-#{node["php"][:version]}.tgz"
end


php_opts = []
php_opts << "--with-config-file-path=#{node["php"][:prefix]}/etc"
php_opts << "--with-config-file-scan-dir=#{node["php"][:prefix]}/etc/php"
php_opts << "--prefix=#{node["php"][:prefix]}"
php_opts << "--with-pear=#{node["php"][:prefix]}/pear"
php_opts << "--enable-fpm"

php_exts = []
php_exts << "--with-gd"
php_exts << "--with-zlib"
php_exts << "--with-bz2"
php_exts << "--with-jpeg-dir=/usr/local/lib/"
php_exts << "--with-freetype"
php_exts << "--with-freetype-dir=/usr/local/lib"
php_exts << "--enable-gd-native-ttf"
php_exts << "--enable-exif"
php_exts << "--enable-mbstring"
php_exts << "--enable-pcntl"
php_exts << "--enable-shmop"
php_exts << "--with-openssl"
#php_exts << "--with-mysql=mysqlnd"
php_exts << "--with-mysqli=mysqlnd"
php_exts << "--with-pdo-mysql=mysqlnd"
#php_exts << "--with-pgsql"
php_exts << "--with-curl"
php_exts << "--with-xsl"
php_exts << "--with-mcrypt"
php_exts << "--enable-sockets"
php_exts << "--enable-soap"
php_exts << "--with-gmp"
php_exts << "--enable-bcmath"
#php_exts << "--with-ldap"
php_exts << "--with-bz2"
php_exts << "--enable-intl"
php_exts << "--enable-zip"
php_exts << "--with-gettext"


execute "PHP: ./configure" do

  cwd "/tmp/php-#{node["php"][:version]}"
  environment "HOME" => "/root"

  command "./configure #{php_opts.join(' ')} #{php_exts.join(' ')}"

end


execute "PHP: make -j`nproc`, make install" do
  cwd "/tmp/php-#{node["php"][:version]}"
  environment "HOME" => "/root"
  command "make && make install"
end


template "/usr/local/etc/php.ini" do
  source "php.ini.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
  )
end

template "/usr/local/etc/php-fpm.conf" do
  source "php-fpm.ini.erb"
  mode 0644
  owner "root"
  group "root"
  variables(
  )
end


directory "/usr/local/etc/php" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end
directory "/usr/local/etc/fpm.d" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

template "/usr/local/etc/php/custom.ini" do
  source "config.d/custom.ini.erb"
  mode 0644
  owner "root"
  group "root"
end


template "/usr/local/etc/fpm.d/custom.conf" do
  source "fpm.d/custom.ini.erb"
  mode 0644
  owner "root"
  group "root"
end


execute "set /etc/init.d/php-fpm" do
  cwd "/tmp/php-#{node["php"][:version]}"
  command "sudo cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm"
end

execute "set /etc/init.d/php-fpm" do
  cwd "/tmp/php-#{node["php"][:version]}"
  command "sudo chmod u+x /etc/init.d/php-fpm"
end

execute "php-fpm: update run level" do
  command "sudo update-rc.d php-fpm defaults"
end
