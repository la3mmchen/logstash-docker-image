FROM valerianomanassero/java-centos:latest

RUN rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
ADD logstash.repo /etc/yum.repos.d/logstash.repo
RUN yum -y install logstash-5.4.0-1 sudo unzip
RUN yum -y clean all
ADD logstash.yml /etc/logstash/logstash.yml
ADD log4j2.properties /etc/logstash/log4j2.properties
ADD jvm.options /etc/logstash/jvm.options
ADD sudoers /etc/sudoers
ADD conf.d/logstash.conf /etc/logstash/conf.d/logstash.conf
ENV JAVACMD /usr/bin/java
USER root
RUN chown logstash:logstash /etc/logstash/logstash.yml
#RUN /usr/share/logstash/bin/logstash-plugin  install -b https://distfiles.compuscene.net/logstash/elasticsearch-prometheus-exporter-5.4.0.0.zip
COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh
USER logstash
ENTRYPOINT ["/docker-entrypoint.sh"]
