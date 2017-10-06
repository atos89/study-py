FROM centos:6.7

MAINTAINER atos990@gmail.com

RUN \
    yum -y update && \
    yum -y install tar && \
    yum -y install wget && \
    yum -y install zip && \
    yum -y install zsh && \
    yum -y install vim && \
    yum -y install git && \
    yum -y install nc && \
    yum -y install curl && \
    yum -y install zsh && \
    wget https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    rpm -ivh epel-release-6-8.noarch.rpm && \
    wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
    rpm -ivh remi-release-6.rpm

RUN \
    yum -y install mysql && \
    yum -y install mysql-server

RUN \
    yum -y install httpd && \
    yum -y install httpd-devel && \
    yum -y install php-mysql && \
    yum -y install php-bcmath && \
    yum -y install php-dba && \
    yum -y install php-devel && \
    yum -y install php-gd && \
    yum -y install --enablerepo=epel php-mcrypt && \
    yum -y install php-mbstring && \
    yum -y install --enablerepo=remi-php56 php

RUN \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN \
    yum install -y https://centos6.iuscommunity.org/ius-release.rpm && \
    yum install -y python36u && \
    yum install -y python36u-libs && \
    yum install -y python36u-devel && \
    ln -s /usr/bin/python3.6 /usr/bin/python3 && \
    unlink /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3.6 /usr/bin/pip

RUN \
    usermod -u 1000 apache && \
    mkdir -p /var/log/php

COPY etc/httpd.conf /etc/httpd/conf/httpd.conf

WORKDIR /home

ENTRYPOINT \
    /etc/init.d/httpd start && \
    /bin/zsh
