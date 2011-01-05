execute "couchDB: apt-get build-dep" do
  command "apt-get build-dep couchdb"
end



package "libicu-dev"
package "libcurl4-gnutls-dev"
package "libtool"

#package "xulrunner-dev"

#test if a js lib is available
#sudo apt-get -s install libmozjs
package "libmozjs0d"
