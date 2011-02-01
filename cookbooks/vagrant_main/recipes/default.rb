require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql::server"
require_recipe "php::php5"
require_recipe "git"

# Some neat package (subversion is needed for "subversion" chef ressource)
%w{ debconf php5-xdebug subversion mc htop }.each do |a_package|
  package a_package
end

s = "dev-site"
site = {
  :name => s, 
  :host => "www.#{s}.com", 
  :aliases => ["#{s}.com", "dev.#{s}-static.com"]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/vagrant/public/"
end  

# Add site info in /etc/hosts
bash "info_in_etc_hosts" do
  code "echo 127.0.0.1 #{site[:host]} #{site[:aliases]} >> /etc/hosts"
end

# Retrieve webgrind for xdebug trace analysis
subversion "Webgrind" do
  repository "http://webgrind.googlecode.com/svn/trunk/"
  revision "HEAD"
  destination "/var/www/webgrind"
  action :sync
end

# Retrieve adminer
git "Adminer" do
  repository "https://github.com/vrana/adminer.git"
  revision "HEAD"
  destination "/var/www/adminer/"
  action :sync
end

# Latest Zend Framework version
subversion "Zend" do
  # repository "http://framework.zend.com/svn/framework/standard/trunk/library/"
  repository "http://framework.zend.com/svn/framework/standard/tags/release-1.11.3/library/"
  revision "HEAD"
  destination "/srv/lib/php/"
  action :sync
end

# Add an admin user to mysql
execute "add-admin-user" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} -e \"" +
      "CREATE USER 'myadmin'@'localhost' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'localhost' WITH GRANT OPTION;" +
      "CREATE USER 'myadmin'@'%' IDENTIFIED BY 'myadmin';" +
      "GRANT ALL PRIVILEGES ON *.* TO 'myadmin'@'%' WITH GRANT OPTION;\" " +
      "mysql"
  action :run
  ignore_failure true
end
