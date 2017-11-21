# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:latest
MAINTAINER Kevin McGarry <kevinjmcgarry@gmail.com>

RUN yum -y update; yum clean all
RUN yum -y install sudo openssh-server passwd; yum clean all
RUN mkdir /var/run/sshd

# Setup ansible user
RUN useradd ansible -s /bin/bash
RUN mkdir -p /home/ansible/.ssh/
RUN mkdir -p /etc/sudoers.d/
RUN chmod 0700 /home/ansible/.ssh/
COPY ssh_config /home/ansible/.ssh/config

### This is just for testing purposes. Keys never go in repos!!! ###
COPY ansiblepriv /home/ansible/.ssh/id_rsa
COPY ansiblepriv.pub /home/ansible/.ssh/id_rsa.pub
COPY ansiblepriv.pub /home/ansible/.ssh/authorized_keys

RUN chown -R ansible:ansible /home/ansible/
RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ansible

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

# EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

# ssh -o StrictHostKeyChecking=no -v -p 2222 -i ~/.ssh/ansiblepriv ansible@localhost
