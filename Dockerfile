FROM centos:latest

MAINTAINER Steve Carney <performance.lab.computing@gmail.com>

RUN yum install -y git python gcc ncurses-devel tmux node-gyp glibc-static epel-release
RUN yum install -y nodejs
RUN yum groupinstall -y development
RUN yum update

# Download C9
RUN git clone https://github.com/c9/core.git /opt/c9

# Install C9
RUN /opt/c9/scripts/install-sdk.sh

# Install Ansible
RUN yum install -y ansible

# Install Docker
COPY docker.repo /etc/yum.repos.d/

RUN yum install -y docker-engine

EXPOSE 8080

CMD cd /opt/c9/ && node server.js -l 0.0.0.0 -p 8080  -w ~/workspace/ -a :