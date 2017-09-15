FROM mamohr/centos-java
USER root
ENV JAVACMD /usr/bin/java
ENV GOPATH /go-shizzle
RUN mkdir /go-shizzle && \
    rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
ADD logstash.repo /etc/yum.repos.d/logstash.repo
RUN yum -y install logstash-5.4.0-1 sudo unzip golang git && \
    yum -y clean all
ADD logstash.yml /etc/logstash/logstash.yml
ADD log4j2.properties /etc/logstash/log4j2.properties
ADD jvm.options /etc/logstash/jvm.options
ADD sudoers /etc/sudoers
ADD conf.d/logstash.conf /etc/logstash/logstash.conf
RUN chown logstash:logstash /etc/logstash/logstash.yml && \
    go get -u github.com/kardianos/govendor && \
    go get -u github.com/DagensNyheter/logstash_exporter && \
    cd $GOPATH/src/github.com/DagensNyheter/logstash_exporter && /go-shizzle/bin/govendor build +local
COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh
USER logstash
ENTRYPOINT ["/docker-entrypoint.sh"]
