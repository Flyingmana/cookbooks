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
	pear install -f phpDocumentor
	pear install -f pear.phpunit.de/PHPUnit
	pear install -f pear.phpunit.de/phploc
	pear install -f pear.pdepend.org/PHP_Depend-beta
	pear install -f pear.xplib.de/PHP_CodeSniffer_Standards_Ezc-beta
	pear install -f pear.arbitracker.org/PHP_CodeSniffer_Standards_Arbit-beta
	pear install -f pear.arbitracker.org/PHPillow-beta
	pear install -f pear.phing.info/phing
	pear install -f pecl.php.net/xdebug
	pear install -f pecl.php.net/apc
	pear install -f pear.pdepend.org/PHP_Depend_Log_Arbit
	pear install -f PHP_CodeSniffer
	pear install -f pearhub.org/FluentDOM
	pear install -f pear.netpirates.net/Autoload
  EOH
end

# install of xdebug and apc seems not to work till now


execute "PEAR: upgrade all packages" do
  command "pear upgrade-all"
end
