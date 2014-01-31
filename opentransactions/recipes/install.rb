include_recipe "helper::package_update"

package "wget"
package "git"
package "libtool"
package "make"
package "cmake"
package "pkg-config"
package "automake"
#package "hurd-dev"
package "libboost-all-dev"
package "libzmq-dev"
package "libmsgpack-dev"
package "libssl-dev"
package "protobuf-compiler"
package "libprotobuf-dev"


package "openjdk-6-jdk"
package "openjdk-6-source"
package "libperl-dev"
package "php5-dev"
package "ruby"
package "ruby-dev"
package "tcl"
package "tcl-dev"
package "python-dev"
package "mono-mcs"
package "monodevelop"
package "gdc"

git "/opt/chaiscript" do
  repository "git://github.com/ChaiScript/ChaiScript.git"
  reference "master"
  action :sync
end


script "chaiscript: make, make install" do
  interpreter "bash"
  user "root"
  cwd "/opt/chaiscript"
  code <<-EOH
	cmake . -DCMAKE_INSTALL_PREFIX=$HOME/.local
  make
  make test
  make install
  export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH
  EOH
end


