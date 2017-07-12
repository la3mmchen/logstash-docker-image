#!/bin/sh
/go-shizzle/bin/logstash_exporter -exporter.bind_address :8082 -logstash.endpoint http://localhost:8082/_prometheus/metrics &
/usr/share/logstash/bin/logstash -f /etc/logstash/logstash.conf
