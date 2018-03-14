FROM centos:latest
MAINTAINER Kevin McGarry <kevinjmcgarry@gmail.com>

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

# generate host keys if they do not exist for root user
RUN ssh-keygen -A

# install Python3.6.x and other tools
RUN yum install yum-utils -y && yum groupinstall development -y
RUN yum install https://centos7.iuscommunity.org/ius-release.rpm -y && yum install python36u -y
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
RUN yum install which vim -y

# Switch user to Ansible and install Ansible 2.4.x
USER ansible
RUN sudo yum install ansible -y

# generate ansible user ssh keys automatically
# RUN ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -b 4096 -N ''

# Switch user back to root to run sshd
USER root

# Copy hosts file
COPY ../Ansible/hosts /etc/ansible/
COPY ../Ansible/playbooks/ /etc/ansible/playbooks/

# EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
