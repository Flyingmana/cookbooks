include_recipe "git-cola::prepare"

remote_file "/tmp/git-cola-#{node["git-cola"][:version]}.tgz" do
  source "https://github.com/davvid/git-cola/tarball/v#{node["git-cola"][:version]}"
  checksum node["git-cola"][:checksum]
end

execute "git-cola: unpack" do
  command "cd /tmp && tar -xzf git-cola-#{node["git-cola"][:version]}.tgz"
end

  
execute "git-cola: install" do
  cwd "/tmp/#{node["git-cola"][:subfolder]}"
  environment "HOME" => "/root"
  command "make prefix=#{node["git-cola"][:prefix]} install"
end
