include_recipe "helper::package_update"

package "iotop"
package "atop"
package "git"
package "varnish"


remote_file "/usr/bin/n98-magerun.phar" do
  source "https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar"
  mode 0755
end

remote_file "/usr/bin/composer.phar" do
  source "https://getcomposer.org/composer.phar"
  mode 0755
end


