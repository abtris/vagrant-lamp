Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "base"


  config.vm.forward_port("http", 80, 8080)
  config.vm.forward_port("mysql", 3306, 3306)
  config.vm.forward_port("couchdb", 5984, 5984)

  config.vm.provision :chef_solo do |chef|
     chef.cookbooks_path = "cookbooks"
  	 chef.json.merge!({
     	:mysql => {
     		:server_root_password => "root"
	 	}
  	 })	
	 chef.add_recipe("vagrant_main") 		
  end

  
end
