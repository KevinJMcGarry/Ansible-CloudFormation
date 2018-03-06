# Ansible with Docker


#### Internal Demonstration of Ansible using Docker-Compose for the environment  

## Place holder info to update

- create keypair
- aws iam user with correct permissions and local cli profile
- cd into Terraform
- add more steps
- ssh-agent
- docker
- note depends on (nat gateway for ec2s, ec2s for elb)
- output of elb and pub ip of ansible control
- talk about putting everything in private subnet in prod using bastion host to connect to ansible control
- git clone
- even though public keys are public, I still like to treat them with a bit of security. copy pub key over and inject it into container at runtime via an argument
- sudo docker build -t ansiblecontrol --build-arg SSH_PUB_KEY="$(cat /home/ec2-user/.ssh/ansibletest.pub)" -f /home/ec2-user/Ansible-Terraform-Docker/Dockerfile .
- sudo docker run -d -p 2222:22 ansiblecontrol # running on port 2222 with only access from outside
- ssh standard port will take you to the ec2 instance
- ssh to 2222 will take you to ansible container on ec2 instance



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
