FROM centos:latest
MAINTAINER Artem Sidorenko <artem@2realities.com>

#enable man pages installation
RUN sed -i '/nodocs/d' /etc/yum.conf ; \
    yum -y install man-pages man-db epel-release ; \
    yum clean all

RUN yum -y install openssh-server openssh-clients supervisor sudo rsync;\
    sed -i '/requiretty/d' /etc/sudoers; \
    yum clean all

#password is vagrant
RUN useradd -m -p '$6$UFLdXsV4$hnP4J2l8w02eCoj7ogsQZ0wdEImAKtzIoQqmrNLEXkyI1UsuPPofdpf4DMViq4QPdFVOz0yekQ35lgaFUB6SF/' -s /bin/bash vagrant

COPY assets /

RUN /usr/local/sbin/sshd_generate_keys

RUN chown -R vagrant:vagrant /home/vagrant; \
    chmod 600 /home/vagrant/.ssh/authorized_keys

CMD supervisord -c /etc/supervisord.conf
EXPOSE 22
