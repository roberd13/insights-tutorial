# Insights Demo Using Docker Images

### In this simple tutorial we will walk through enabling the new [Metrics Collector](https://docs.datastax.com/en/dse/6.7/dse-dev/datastax_enterprise/tools/metricsCollector/mcIntroduction.html) in a DataStax Enterprise (DSE) 6.7 Docker Container, exporting the metrics to Promethius Docker Container and visualizing these metrics with a Grafana Docker container. 

This Tutorial was created using a DSE 6.7, Promethius 2.4.3 amd Grafana 5.3.2 containers .

## Prerequisites

* Basic understanding of Docker images and containers. 

* Docker installed on your local system, see [Docker Installation Instructions](https://docs.docker.com/engine/installation/). 

* Docker Compose installed, see [Install Docker Compose](https://docs.docker.com/compose/install)

* Our Docker Images are hosted on [Docker Hub](https://hub.docker.com/r/datastax/dse-server/). For documentation including configuration options, environment variables, and compose examples head over to our official [Docker Docs](https://docs.datastax.com/en/docker/doc/index.html?utm_campaign=Docker_Cus_2019&utm_medium=web&utm_source=docker&utm_term=&utm_content=Web_DocsDocker)

## Getting Started

Lets start by creating a directory to work from.  From a CLI prompt create a directory in your home directory called insights and change to that directory


```
mkdir ~/insights && cd ~/insights
```

## Demo Data

To get the demo data, I have created a script [insights.sh](https://github.com/roberd13/insights-tutorial/blob/master/insights.sh) to download all of the config files needed for this tutorial. This script will create the directory structure and download the files to be used with the volume mounts for the containers. 
Download the script using the following command 

```
curl https://raw.githubusercontent.com/roberd13/insights-tutorial/master/insights.sh -o insights.yaml && chmod +x insights.yaml

```

## Starting the Containers

Now start the containers using the downloaded insights-compose.yaml 

```
docker-compose -f insights-compose.yaml up -d 
```

The compose yaml will mount volumes to the promethius and grafana containers using the files we downloaded.

## Configuring DSE to send metrics

Now we need to configure the dse container to send metrics to promethius. To do this we have a preconfigured promethius.conf file you downloaded earlier.  We need to copy this to the container .

```
docker cp promethius.conf dse-server:/opt/dse/resources/dse/collectd/etc/collectd/promethius.conf
```

Now we need to stop and restart the metrics collecton

```
docker exec -it dse-server dsetool insights_config --mode DISABLED
```

```
docker exec -it dse-server dsetool insights_config --mode ENABLED_WITH_LOCAL_STORAGE
```

## Viewing the Metrics in Grafana

Everything should be up and running and you can now see the metrics using the preconfigured grafana dashboards by visiting 

http://localhost:3000/dashboards
