execute "PEAR: enable auto discover for channels" do
  command "pear config-set auto_discover 1"
end

script "PEAR: discover channels" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  	pear channel-discover pear.phpunit.de
	pear channel-discover pear.pdepend.org
	pear channel-discover pear.xplib.de
	pear channel-discover pear.phing.info
	pear channel-discover pear.arbitracker.org
	pear channel-discover components.ez.no
	pear channel-discover pearhub.org
	pear channel-discover pear.symfony-project.com
	pear channel-discover pear.netpirates.net
  EOH
end


execute "PEAR: update channel" do
  command "pear channel-update pear.php.net"
end

script "PEAR: install packages" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  	pear install phpDocumentor
	pear install phpunit/PHPUnit
	pear install phpunit/phploc
	pear install pdepend/PHP_Depend-beta
	pear install xplib/PHP_CodeSniffer_Standards_Ezc-beta
	pear install arbit/PHP_CodeSniffer_Standards_Arbit-beta
	pear install arbit/PHPillow-beta
	pear install phing/phing
	pear install pecl/xdebug
	pear install pdepend/PHP_Depend_Log_Arbit
	pear install PHP_CodeSniffer
	pear install pearhub/FluentDOM
	pear install theseer/Autoload
  EOH
end




execute "PEAR: upgrade all packages" do
  command "pear upgrade-all"
end
