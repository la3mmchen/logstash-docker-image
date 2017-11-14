FROM mamohr/centos-java

USER root

ENV JAVACMD /usr/bin/java

RUN rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

ADD logstash.repo /etc/yum.repos.d/logstash.repo

RUN yum -y install logstash-6.0.0~rc2-1 sudo && \
    yum -y clean all

ENV LS_HOME /usr/share/logstash
RUN mkdir $LS_HOME/config
RUN mkdir /logstash
ADD logstash.yml $LS_HOME/config/logstash.yml
#ADD log4j2.properties $LS_HOME/config/log4j2.properties
ADD jvm.options $LS_HOME/config/jvm.options
ADD conf.d/logstash.conf $LS_HOME/conf.d/logstash.conf

RUN /usr/share/logstash/bin/logstash-plugin install x-pack

COPY docker-entrypoint.sh /

RUN chmod 755 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
