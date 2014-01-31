include_recipe "helper::package_update"

package "build-essential"
package "g++"
package "sqlite3"
package "libsqlite3-dev"
package "ruby-sqlite3"

gem_package "mailcatcher" do
  action :install # see actions section below
end



file "/etc/init.d/mailcatcher" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  content '#! /bin/sh
# /etc/init.d/mailcatcher
#

# Some things that run always
# touch /var/lock/blah

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo -n "Starting mailcatcher: "
    /usr/bin/env mailcatcher --http-ip 0.0.0.0
    echo "."
    ;;
  *)
    echo "Usage: /etc/init.d/mailcatcher {start}"
    exit 1
    ;;
esac

exit 0'
end

execute "mailcatcher: update run level" do
  command "update-rc.d mailcatcher defaults"
end


file "/usr/local/etc/php/mailcatcher.ini" do
  owner "root"
  group "root"
  mode "0644"
  action :create
  content '
sendmail_path = /usr/bin/env catchmail -f some@from.address
'
end

