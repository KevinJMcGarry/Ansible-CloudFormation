## Dockerfile to create the Ansible Control enviroment ##

FROM centos:latest
MAINTAINER Kevin McGarry <kevinjmcgarry@gmail.com>

# Install ssh server
RUN yum -y update && yum clean all
RUN yum -y install sudo openssh-server passwd && yum clean all
RUN mkdir /var/run/sshd

# Setup ansible user
RUN useradd ansible -s /bin/bash
RUN mkdir -p /home/ansible/.ssh/
RUN mkdir -p /etc/sudoers.d/
COPY ./Ansible/ssh_config /home/ansible/.ssh/config
RUN chmod 0744 /home/ansible/.ssh/config

# Argument to add local pub key for ssh access
ARG SSH_PUB_KEY
RUN echo "${SSH_PUB_KEY}" > /home/ansible/.ssh/authorized_keys

RUN chown -R ansible:ansible /home/ansible/
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

# Generate host keys if they do not exist for root user
RUN ssh-keygen -A

# Install Python3.6.x and other tools
RUN yum install yum-utils -y && yum groupinstall development -y
RUN yum install https://centos7.iuscommunity.org/ius-release.rpm -y && yum install python36u -y
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
RUN yum install which vim -y
RUN yum install python-pip -y && pip install --upgrade pip -y
RUN yum install jq -y
RUN yum install wget -y

# Install Ansible 2.4.x
RUN yum install ansible -y

# Install AWS CLI Tools & SDK
RUN pip install awscli --upgrade --user
RUN pip install boto

# generate ansible user ssh keys automatically. Keeping this for reference.
# RUN ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -b 4096 -N ''

# Copy hosts file
COPY ./Ansible/hosts /etc/ansible/
COPY ./Ansible/playbooks/ /etc/ansible/playbooks/

# Download Ansible AWS Dynamic Inventory Python script and Copy in Modified ini file
RUN wget https://raw.github.com/ansible/ansible/devel/contrib/inventory/ec2.py -P /etc/ansible/ec2.py
RUN chmod +x /etc/ansible/ec2.py
RUN ./Docker/ec2.ini /etc/ansible/ec2.ini

# Post login shell script for AWS env vars that get lost between shell sessions
COPY ./Docker/awsparams.sh /etc/profile.d/awsparams.sh

# EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
