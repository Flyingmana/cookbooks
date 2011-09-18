
# you get an error relatet  to ca-certificates-java? You are in a virtual environment? install sun java before
execute "couchDB: apt-get build-dep" do
  command "apt-get build-dep -y couchdb"
end



package "libicu-dev"
package "libcurl4-gnutls-dev"
package "libtool"

#package "xulrunner-dev"

#test if a js lib is available
#sudo apt-get -s install libmozjs
package "libmozjs-dev"
# package "libmozjs0d"
