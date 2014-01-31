# http://www.fromdual.com/mpm-installation-guide
# http://www.fromdual.com/mysql-performance-monitor
#
#
#


package "libfile-which-perl"
package "libwww-perl"
package "libdigest-sha-perl"
package "libdigest-sha1-perl"
package "libdbd-mysql-perl"
package "libtime-hires-perl"
package "libcrypt-ssleay-perl"

agent_tar_name = "mysql_performance_monitor_agent-0.9.1"
template_tar_name = "mysql_performance_monitor_templates-0.9.1"

cookbook_file "/tmp/#{agent_tar_name}.tar.gz" do
  source "#{agent_tar_name}.tar.gz"
  mode "0644"
end

cookbook_file "/tmp/#{template_tar_name}.tar.gz" do
  source "#{template_tar_name}.tar.gz"
  mode "0644"
end
