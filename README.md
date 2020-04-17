# Atlas dev setup

## About 
Builds and installs [OHDSI ATLAS](https://www.ohdsi.org/atlas-a-unified-interface-for-the-ohdsi-tools/) in a VM.  
Mainly intended to help with setting up for development. Still very much a work in progress. The local deployement will use the VM but
the server deployment will use the Tomcat installed on the server.  

A similar GitHub repo using playbooks to deploy can be found at https://github.com/cid-harvard/atlas-playbooks and can help give some guidance on setting things up.

## Dependencies
* [ansible 2.7+](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [jmespath](https://pypi.org/project/jmespath/)
* [Vagrant 2.2.2](https://www.vagrantup.com/intro/getting-started/install.html)
* [Virtual Box 5.2.22](https://www.vagrantup.com/intro/getting-started/install.html)

## Running
* Install dependencies
    ```
    pip install ansible jmespath
    ```
## Getting Vocabularies
In order to load the vocabulary, the vocabulary first needs to be downloaded from http://athena.ohdsi.org.

After downloading the vocabulary, you'll receive and email to download a zip file. Move the contents of the zip file to the playbooks/data/roles/vocabulary/files/ directory and follow the additional instructions in the readme.txt file adding the CPT4 codes to CONCEPT.csv.

You will have to register for an account with https://utslogin.nlm.nih.gov/cas to complete the vocabulary creation process.  This can take a few days.

cpt4.jar provided with the vocabulary appears to require java 8. 

### Local environment Development Environment Setup
These steps are used for setting up a local virtual machine that can run an instance of Atlas
* `vagrant up`
* Once ansible finishes: 
    * Atlas will be running at (http://localhost:8080/atlas/)
    * The source code for the various projects used in Atlas can be found on the host machine under `src`
    
### Server Deployment
* The playbook can also be used to deploy Atlas to a remote server.  
    * copy either of the existing provisioning directories (`tests` or `vagrant`)
    * update any variables needed in the `group_vars` directory
	* check that the remote server still has Tomcat8 installed in the /opt/tomcat directory
    * update the ip addresses of the various components in the inventory file, and the location of the ssh keys
    * Then run the playbook `ansible-playbook -i provisioning/server/inventory configure.yml --become`
        * This assumes that the ssh user came run commands as `sudo`

###Using Windows for Deployment or Local Build

The playbooks are not compatible with a normal Windows environment but can be used with the Windows Subsystem for Linux (WSL) [https://docs.microsoft.com/en-us/windows/wsl/install-win10](https://docs.microsoft.com/en-us/windows/wsl/install-win10).  This lets you run an instance of Linux from inside Windows 10.  

To run from the playbooks from WSL instance: 

* Create SSH keys between the WSL and the remote server.
* Install the dependencies
	*	You may have to install Python3, PIP, or other items not listed here depending on the WSL Distrubution you decided to use.
* Clone this GitHub repo 
* Update the values for your machine and the remote server in 
	* `[LocalGitRepo]/provisioning/vagrant/inventory`
	* `[LocalGitRepo]/provisioning/vagrant/group_vars/data.yml`
		* The data_download_dir is the directory on the remote server where all of the files will be copied to
	* `[LocalGitRepo]/provisioning/vagrant/group_vars/db.yml`
		* The db_name is where the database will be deployed. Be sure this is a database that does NOT exist on the machine already or you may risk overwriting data
	* [LocalGitRepo]/provisioning/vagrant/group_vars/www.yml
		* The `www_download_dir` is the directory on the remote server where the web server files will be copied
	* `[LocalGitRepo]/playbooks/www/roles/atlas/tasks/main.yml`
		* Check the Atlas version listed to ensure the correct version is obtained from GitHub
			
```
$ ansible-playbook -i provisioning/vagrant/inventory configure.yml  --become --extra-vars "ansible_sudo_pass=<your_sudo_password>!"   
```

If you plan to have more than one version of Atlas running at the same time on the same server, you will have to do some additional steps to get it to work. 

You will need to rebuild the WebAPI war file on the server.  

* From the directory where you deployed the git downloads on the remote server (the `www_download_dir` from the playbooks).  
* Go to the WebAPI directory.  
* Locate the `src` directory and navigate to `src/main/resources` and locate the `application.properties` file
* Edit the file with `sudo vi application.properties`
* Add the following line to the end of the file: `spring.jmx.default-domain = WebAPI2`
 * Set the default-domain property to any value that will be unique, usually just the name of the application.
* Edit the `path` property in `src/main/webapp/META-INF/context.xml`  to the new app name
* Rebuild the application WAR file with `mvn clean package -s WebAPIConfig/settings.xml -P webapi-postgresql`
* Copy the WAR file to the Tomcat directory(usually `/var/lib/tomcat8`)
* Navigate up to the Atlas application download directory and edit the path in `src/main/webapp/META-INF/context.xml` for that applications name
* Copy that directory to the Tomcat directory.  The file path will specify the new application name.
* Restart the Tomcat service `sudo service Tomcat8 restart`
