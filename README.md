# Insights Demo Using Docker Images

### In this simple tutorial we will walk through enabling the new Metrics Collector in a DataStax Enterprise (DSE) 6.7 Docker Container, exporting the metrics to Prometheus Docker Container and visualizing these metrics with a Grafana Docker container.

This Demo is created using a DSE 6.7, Prometheus 2.4.3 amd Grafana 5.3.2 containers .

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

To get the demo data, I have created a simple script [insights.sh](https://github.com/roberd13/insights-tutorial/blob/master/insights.sh) to download all of the config files needed for this demo. This script will create the directory structure and download the files needed to be used with the volume mounts for the containers. 
Download the script using the following command 

```
wget -L https://raw.githubusercontent.com/roberd13/insights-tutorial/master/insights.sh -O insights.sh && chmod +x insights.sh
```

Run the script to download the demo data.

```
./insights.sh
```

## Starting the Containers

Now start the containers using the downloaded insights-compose.yaml 

The insights-compose.yaml 
* Pull the images from Docker Hub
* Creates a bridged network for the containers to communicate on
* Maps the volumes to containers with the files we downloaded
* Publishes the ports for insights, prometheus and grafana
* Creates an alias for the dse container to use as the address in our custom `tg_dse.json` 

```
docker-compose -f insights-compose.yaml up -d 
```

The compose yaml will mount volumes to the prometheus and grafana containers using the files we downloaded.

## Configuring DSE to send metrics

Now we need to configure the dse container to send metrics to prometheus. To do this we have a preconfigured prometheus.conf file you downloaded earlier.  We need to copy this to the container .

```
docker cp prometheus.conf dse-server:/opt/dse/resources/dse/collectd/etc/collectd/prometheus.conf
```

Next we need to stop and restart metrics collecton

```
docker exec -it dse-server dsetool insights_config --mode DISABLED
```

```
docker exec -it dse-server dsetool insights_config --mode ENABLED_WITH_LOCAL_STORAGE
```

## Viewing the Metrics in Grafana

It may take a few minutes for metrics to populate but everything should be up and running and you can now see the metrics using the preconfigured grafana dashboards by visiting 

http://localhost:3000/dashboards or http://docker-host-ip:3000/dashboards 

## Destroy the Demo

Destroying the demo is as simple as running the command 

```
docker-compose -f insights-compose.yaml down
```

All the config files are still located on your host so if you decided to run the demo again, as long as you don't delete the data in ~/insights all you have to do is run the below command again from the ~/insights directory and you will be back where you were prior to destroying.

```
docker-compose -f insights-compose.yaml up -d 
```

## What Next

If you want more granular configuration details or how to configure for existing cluster check out our [Metrics Collector Documentation](https://docs.datastax.com/en/dse/6.7/dse-dev/datastax_enterprise/tools/metricsCollector/mcIntroduction.html)
