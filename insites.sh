#!/bin/bash

# Download the promethius configs

mkdir promethius

wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/prometheus/prometheus.yml -O promethius/prometheus.yml
wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/prometheus/tg_dse.json -O promethius/tg_dse.json
sed -ri 's/(127.0.0.1:9103).*/\1 '"dse-server"'tg_dse.json' 

# Download the grafana configs

mkdir grafana
wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/grafana/dashboards.yaml -O grafana/dashboards.yaml
wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/grafana/prometheus-datasource.yaml -O grafana/prometheus-datasource.yaml

# Makd dashboards directory
mkdir grafana/dashboards

wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/grafana/dashboards/dse-cluster-condensed.json -O grafana/dashboards/dse-cluster-condensed.json
wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/grafana/dashboards/dse-cluster-metrics.json -O grafana/dashboards/dse-cluster-metrics.json
wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/grafana/dashboards/prometheus-metrics.json -O grafana/dashboards/prometheus-metrics.json
wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/grafana/dashboards/system-metrics.json -O grafana/dashboards/system-metrics.json

