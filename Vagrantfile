VGRANTFILE_API_VERSION = "2"
Vagrant.configure("2") do |config|
  required_plugins = %w(vagrant-vbguest vagrant-disksize)
  _retry = false
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin? plugin
      system "vagrant plugin install #{plugin}"
      _retry=true
    end
  end
  if (_retry)
    exec "vagrant " + ARGV.join(' ')
  end

  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder "src/", "/vagrant", disabled: false
  config.disksize.size = '50GB'

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
     #ansible.verbose  = true
     ansible.playbook = "configure.yml"
     ansible.inventory_path = "provisioning/vagrant/inventory"
     ansible.extra_vars = {
        ansible_ssh_user: 'vagrant',
        ansible_ssh_private_key_file: ".vagrant/machines/www/virtualbox/private_key",
        ansible_ssh_host: "127.0.0.1",
        ansible_ssh_port: "2222"}
  end
end
