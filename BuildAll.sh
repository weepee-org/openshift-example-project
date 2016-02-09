#!/bin/bash

oc new-project example \
    --description="Examples - static, php, mojo, hhvm, proxy" \
    --display-name="Examples"

echo "static"
oc create -f static/BuildConfig.yaml
oc create -f static/ImageStream.yaml
oc create -f static/DeploymentConfig.yaml
oc create -f static/Services.yaml
oc start-build static

echo "php"
oc create -f php/BuildConfig.yaml
oc create -f php/ImageStream.yaml
oc create -f php/DeploymentConfig.yaml
oc create -f php/Services.yaml
oc start-build php

echo "mojo"
oc create -f mojo/BuildConfig.yaml
oc create -f mojo/ImageStream.yaml
oc create -f mojo/DeploymentConfig.yaml
oc create -f mojo/Services.yaml
oc start-build mojo

echo "hhvm"
oc create -f hhvm/BuildConfig.yaml
oc create -f hhvm/ImageStream.yaml
oc create -f hhvm/DeploymentConfig.yaml
oc create -f hhvm/Services.yaml
oc start-build hhvm

echo "proxy"
oc create -f proxy/BuildConfig.yaml
oc create -f proxy/ImageStream.yaml
oc create -f proxy/DeploymentConfig.yaml
oc create -f proxy/Services.yaml
oc create -f proxy/Route.yaml
oc start-build proxy

echo "wordpress"
oc create -f Gluster-Service.yaml
oc create -f Gluster-Endpoints.yaml
oc create -f wordpress-php/PersistentVolumeClaim.yaml
oc create -f wordpress-php/BuildConfig.yaml
oc create -f wordpress-php/ImageStream.yaml
oc create -f wordpress-php/DeploymentConfig.yaml
oc create -f wordpress-php/Services.yaml
oc create -f wordpress-php/Route.yaml
PASSWORD=$(openssl rand 12 -base64)
echo "DB wordpress USER wordpress PASSWORD ${PASSWORD}"
oc process -f wordpress-php/MysqlTemplate.yaml -v MYSQL_DATABASE=wordpress,VOLUME_CAPACITY=512Mi,MYSQL_USER=wordpress,MYSQL_PASSWORD=${PASSWORD} | oc create -f -
oc start-build wordpress
