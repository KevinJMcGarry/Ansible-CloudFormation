# Ansible with Docker


#### Internal Demonstration of Ansible using Docker-Compose for the environment  

This is a quick infrastructure deployment (using containers) to demonstrate how to use ansible. In the real world you wouldn't use Ansible with containers as **containers are immutable**. 

**lots of tweaks to get sshd and init running in this container**

* Generate local ssh keypair for Ansible User:

    ```bash
    ssh-keygen -t rsa -f ansible```
    
    
    copy keypair to env/ folder from repo **
    
    ** note this is just for demonstration purposes. The Docker Images will be built with the keypair included. This is never done in the real world.    
    ```
    
### Shell access to the containers
* substitute your private key for 'privkey' and port for the appropriate container

	```ssh -o StrictHostKeyChecking=no -v -p 22xx -i ~/.ssh/xxxx ansible@localhost```

* updated steps - all user accounts create automatically

	``` 
		1. shell into control box using main keypair
	    2. su to ansible with sudo rights
	    3. install ansible
	    4. create keypair for user ansible
	    5. copy public key to ansible user on all remote machines - authorized_keys folder
	    6. /etc/sudoers.d/ansible ```
