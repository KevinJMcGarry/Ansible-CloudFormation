# Ansible with Docker


#### Internal Demonstration of Ansible using Docker-Compose for the environment  

* Generate local ssh keypair for Ansible User:

    ```bash
    ssh-keygen -t rsa -f ansible```
    
    
    copy keypair to env/ folder from repo **
    
    ** note this is just for demonstration purposes. The Docker Images will be built with the keypair included. This is never done in the real world.    
    ```
    
### Shell access to the containers
* substitute your private key for 'privkey' and port for the appropriate container

	```ssh -o StrictHostKeyChecking=no -v -p 222x -i ~/.ssh/xxxx ansible@localhost```