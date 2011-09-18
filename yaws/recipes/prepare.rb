execute "yaws: apt-get build-dep" do
  command "apt-get build-dep -y yaws"
end

package "privbind"
