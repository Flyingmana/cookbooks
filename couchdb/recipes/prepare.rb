
# you get an error relatet  to ca-certificates-java? You are in a virtual environment? install sun java before
execute "couchDB: apt-get build-dep" do
  command "apt-get build-dep -y couchdb"
end



package "libicu-dev"
package "libcurl4-gnutls-dev"
package "libtool"
package "erlang-eunit"
package "erlang-nox"


case node["platform"]
  when "ubuntu"
    case node["platform_version"]
      when "10.04"
        packageName = "xulrunner"
      else
        packageName = "libmozjs"
    end
  else
    packageName = "libmozjs"
end

package "#{packageName}-dev"

#test if a js lib is available
#sudo apt-get -s install libmozjs
# package "libmozjs0d"

execute "couchDB: unlink help2man" do
  command "rm -f /usr/bin/help2man && sudo echo "" > /usr/bin/help2man && chmod a+x /usr/bin/help2man"
end


