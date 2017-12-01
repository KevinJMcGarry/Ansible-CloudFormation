# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:latest
MAINTAINER Kevin McGarry <kevinjmcgarry@gmail.com>

RUN yum -y update && yum clean all
RUN yum -y install sudo openssh-server passwd && yum clean all
RUN mkdir /var/run/sshd

# Setup ansible user
RUN useradd ansible -s /bin/bash
RUN mkdir -p /home/ansible/.ssh/
RUN mkdir -p /etc/sudoers.d/
RUN chmod 0700 /home/ansible/.ssh/
COPY ssh_config /home/ansible/.ssh/config

### This is just for testing purposes. Keys never go in repos!!! ###
# ---------------------------------------------------------------------------------------------- #
COPY ansiblepriv /home/ansible/.ssh/id_rsa
COPY ansiblepriv.pub /home/ansible/.ssh/id_rsa.pub
COPY ansiblepriv.pub /home/ansible/.ssh/authorized_keys

RUN chown -R ansible:ansible /home/ansible/
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

# generate host keys that do not exist
RUN ssh-keygen -A 

# install Python3.6.x and other tools
RUN yum install yum-utils -y && yum groupinstall development -y
RUN yum install https://centos7.iuscommunity.org/ius-release.rpm -y && yum install python36u -y
RUN ln -s /usr/bin/python3.6 /usr/bin/python3
RUN yum install which vim -y

# Switch user to Ansible and install Ansible 2.4.x
USER ansible
RUN sudo yum install ansible -y

# Switch user back to root to run sshd
USER root

# Copy hosts file
COPY hosts /etc/ansible/
COPY /playbooks/ /etc/ansible/playbooks/

# EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
