#!/bin/bash
# date: 2020/08/29
# description: grafana support mongodb   datasource
# auth: vera

function install_grafana(){
    # 3000
    docker pull grafana/grafana:6.5.0
    docker build -t grafana/grafana:6.5.1 .
    docker stop grafana
    docker rm grafana
    docker run -d --name grafana --net=host   grafana/grafana:6.5.1
}


function install_mongodb(){
    #27017
    docker pull mongo:4.2.9
    docker stop mongo
    docker rm mongo
    docker run --name mongo --net=host -d   mongo:4.2.9
}

function install_mongodb_proxy(){
    # 3333
    docker pull node:14.8.0
    cd mongodb-proxy && docker build -t   grafana/mongodb-proxy:0.0.1 .
    docker stop mongodb-proxy
    docker rm mongodb-proxy
    docker run -d --name mongodb-proxy   --net=host grafana/mongodb-proxy:0.0.1
}


install_grafana
install_mongodb
install_mongodb_proxy
