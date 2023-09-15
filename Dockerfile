# syntax=docker/dockerfile:1

FROM ubuntu:latest

#unmin the ubuntu image
RUN yes | unminimize

#install baseline tools
RUN apt-get update &&\
    apt-get install -y openssh-server sudo bash vim man &&\
    mkdir /var/run/sshd

#remove default logon messages
RUN sed -i '43,55d' /etc/bash.bashrc &&\
    rm -r /etc/update-motd.d/ &&\
    rm /etc/legal

ARG PASSWORD
#change the root password
RUN echo "root:$PASSWORD" | chpasswd &&\
    chsh -s /bin/bash

#change the default shell to bash
RUN useradd -D -s /bin/bash

#add a fun motd
RUN echo "Welcome to Bare Ubuntu!\n\nHave fun playing around" > /etc/motd

#create the server user and set values as needed
RUN useradd -m server &&\
    adduser server sudo &&\
    echo "server:$PASSWORD" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]