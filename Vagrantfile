VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"

  config.vm.provider :virtualbox do |v|
    v.name = "atlas"
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.define "atlas"
  config.vm.network :forwarded_port, guest: 5432, host: 5432
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :private_network, ip: "192.168.33.10"

  config.vm.provision "ansible" do |ansible|
    ansible.verbose  = true
    ansible.playbook = "provisioning/playbook.yml"
    #ansible.inventory_path = "provisioning/inventory"
  end
end
