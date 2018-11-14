VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.synced_folder "src/", "/vagrant"

  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.define "www" do |www|
    www.vm.hostname = "www.test"
    www.vm.network :private_network, ip: "192.168.33.10"
  end

  config.vm.provision "ansible" do |ansible|
     ansible.limit = "all"
     ansible.verbose  = true
     ansible.playbook = "configure.yml"
     ansible.inventory_path = "provisioning/vagrant/inventory"
     ansible.extra_vars = {
        ansible_ssh_user: 'vagrant',
        ansible_ssh_private_key_file: "~/.vagrant.d/insecure_private_key",
        ansible_ssh_host: "192.168.33.10",
        ansible_ssh_port: "22"}
  end
end
