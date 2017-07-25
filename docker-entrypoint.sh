#!/bin/sh
/go-shizzle/bin/logstash_exporter -exporter.bind_address :8082 &
/usr/share/logstash/bin/logstash --path.data /tmp -f /etc/logstash/logstash.conf
