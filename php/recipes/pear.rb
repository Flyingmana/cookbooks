execute "PEAR: enable auto discover for channels" do
  command "pear config-set auto_discover 1"
end

##script "PEAR: discover channels" do
##  interpreter "bash"
##  user "root"
##  cwd "/tmp"
##  code <<-EOH
##	pear channel-discover pear.phpunit.de
#	pear channel-discover pear.pdepend.org
#	pear channel-discover pear.xplib.de
#	pear channel-discover pear.phing.info
#	pear channel-discover pear.arbitracker.org
#	pear channel-discover components.ez.no
#	pear channel-discover pearhub.org
#	pear channel-discover pear.symfony-project.com
#  #EOH
##end


execute "PEAR: update channel" do
  command "pear channel-update pear.php.net"
end

script "PEAR: install packages" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    #pear config-set php_ini /usr/local/etc/php/custom.ini
	pear install -f pecl.php.net/xdebug
  EOH
end

# install of xdebug and apc seems not to work till now


script "PECL: install packages" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    #pear config-set php_ini /usr/local/etc/php/custom.ini
	pecl install -f ssh2-beta
  EOH
end


execute "PEAR: upgrade all packages" do
  command "pear upgrade-all"
end
