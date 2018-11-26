# Atlas dev setup

## About 
Builds and installs [OHDSI ATLAS](https://www.ohdsi.org/atlas-a-unified-interface-for-the-ohdsi-tools/) in a VM.  
Mainly intended to help with setting up for development. Still very much a work in progress. 

## Dependencies
* [ansible 2.7+](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Vagrant 2.2.0](https://www.vagrantup.com/intro/getting-started/install.html)
* [Virtual Box 5.2.20](https://www.vagrantup.com/intro/getting-started/install.html)

## Running
* `vagrant up`
* Once ansible finishes: 
    * Atlas will be running at [http://192.168.33.10:8080/atlas/](http://localhost:8080/atlas/)
    * The source code for the various projects used in Atlas can be found on the host machine under `src`

