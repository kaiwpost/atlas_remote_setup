Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.define  "atlas"
  # config.disksize.size = "65GB"
  config.vm.network "forwarded_port", guest: 5432, host: 5432
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.provision "ansible" do |ansible|
    # ansible.verbose  = true
    ansible.playbook = "playbook.yml"
  end
  config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
  end
end
