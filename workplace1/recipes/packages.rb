include_recipe "helper::package_update"

package "iotop"
package "atop"


remote_file "/usr/bin/n98-magerun.phar" do
  source "https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar"
  mode 0755
end


