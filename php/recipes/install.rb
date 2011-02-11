include_recipe "php::prepare"

# seems to add an \n
php_installed_version = `which php >> /dev/null && php -v|grep #{node["php"][:version]}|awk '{ print substr($2,1,5) }'`

php_already_installed = (php_installed_version != "")


if !node["php"][:reinstall] && php_already_installed
  return
end

remote_file "/tmp/php-#{node["php"][:version]}.tgz" do
  source "http://www.php.net/get/php-#{node["php"][:version]}.tar.gz/from/www.php.net/mirror"
  checksum node["php"][:checksum]
end

execute "PHP: unpack" do
  command "cd /tmp && tar -xzf php-#{node["php"][:version]}.tgz"
end


php_opts = []
php_opts << "--with-config-file-path=#{node["php"][:prefix]}/etc"
php_opts << "--with-config-file-scan-dir=#{node["php"][:prefix]}/etc/php"
php_opts << "--prefix=#{node["php"][:prefix]}"
php_opts << "--with-pear=#{node["php"][:prefix]}/pear"

php_exts = []
php_exts << "--with-gd"
php_exts << "--with-zlib"
php_exts << "--with-jpeg-dir=/usr/local/lib/"
php_exts << "--enable-exif"
php_exts << "--enable-mbstring"
php_exts << "--enable-pcntl"
php_exts << "--enable-shmop"
php_exts << "--with-openssl"
php_exts << "--with-mysql=mysqlnd"
php_exts << "--with-mysqli=mysqlnd"
php_exts << "--with-pdo-mysql=mysqlnd"
#php_exts << "--with-pgsql"
php_exts << "--with-curl"
php_exts << "--with-tidy"
php_exts << "--enable-sockets"

  
execute "PHP: ./configure" do

  cwd "/tmp/php-#{node["php"][:version]}"
  environment "HOME" => "/root"

  command "./configure #{php_opts.join(' ')} #{php_exts.join(' ')}"

end


execute "PHP: make, make install" do
  cwd "/tmp/php-#{node["php"][:version]}"
  environment "HOME" => "/root"
  command "make && make install"
end
