#!/bin/bash

# Download the promethius configs

mkdir promethius

wget -L https://raw.githubusercontent.com/datastax/dse-metric-reporter-dashboards/master/prometheus/prometheus.yml -O promethius/prometheus.yml
# Download tg_dse.json preconfigured for insites tutorial
wget -L https://raw.githubusercontent.com/roberd13/insights-tutorial/master/tg_dse.json -O promethius/tg_dse.json

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

#Get promethius conf for dse 

wget -L https://raw.githubusercontent.com/roberd13/insights-tutorial/master/prometheus.conf -O prometheus.conf
