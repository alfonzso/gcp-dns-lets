FROM ubuntu:16.04

RUN apt-get -y update            && \
    apt-get -y install              \
        apt-transport-https         \
        ca-certificates             \
        openssh-client              \
        dnsutils                    \
        python python-pip=8.1.1*    \
        git                      && \
        pip install ansible==2.6.5
