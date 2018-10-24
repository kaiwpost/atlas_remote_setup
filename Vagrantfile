Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.define "atlas"
  config.vm.provision "ansible" do |ansible|
    ansible.verbose  = true
    ansible.playbook = "playbook.yml"
  end
end
