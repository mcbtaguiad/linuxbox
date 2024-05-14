FROM redhat/ubi9:latest

LABEL Maintainer="Mark Taguiad <marktaguiad@tagsdev.xyz>"
LABEL Description="CentOS 9 SSH Image"
LABEL CentOS="9"

# add epel
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# add packages
RUN dnf update -y ; \
    dnf upgrade -y ; \
    dnf install -y openssh-clients openssh-server

# generate key
RUN ssh-keygen -A

# allow root to login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# change root password
RUN echo 'root:root123' | chpasswd

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]

