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

echo "php-phalcon"
oc create -f php-phalcon/BuildConfig.yaml
oc create -f php-phalcon/ImageStream.yaml
oc create -f php-phalcon/DeploymentConfig.yaml
oc create -f php-phalcon/Services.yaml
oc start-build php-phalcon

echo "mojo"
oc create -f mojo/BuildConfig.yaml- apache (threading) proxy (openshift-webproxy)

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

echo "wordpress hhvm (replace php)"
oc delete -f wordpress-php/BuildConfig.yaml
oc delete -f wordpress-php/DeploymentConfig.yaml
oc delete -f wordpress-php/Services.yaml
oc create -f wordpress-hhvm/BuildConfig.yaml
oc create -f wordpress-hhvm/DeploymentConfig.yaml
oc create -f wordpress-hhvm/Services.yaml

echo "wordpress hhvm"
# oc create -f Gluster-Service.yaml
# oc create -f Gluster-Endpoints.yaml
# oc create -f wordpress-hhvm/PersistentVolumeClaim.yaml
# oc create -f wordpress-hhvm/BuildConfig.yaml
# oc create -f wordpress-hhvm/ImageStream.yaml
# oc create -f wordpress-hhvm/DeploymentConfig.yaml
# oc create -f wordpress-hhvm/Services.yaml
# oc create -f wordpress-hhvm/Route.yaml
# PASSWORD=$(openssl rand 12 -base64)
# echo "DB wordpress USER wordpress PASSWORD ${PASSWORD}"
# oc process -f wordpress-php/MysqlTemplate.yaml -v MYSQL_DATABASE=wordpress,VOLUME_CAPACITY=512Mi,MYSQL_USER=wordpress,MYSQL_PASSWORD=${PASSWORD} | oc create -f -
# oc start-build wordpress

echo "memsql Master"
#oc create -f Gluster-Service.yaml
#oc create -f Gluster-Endpoints.yaml
oc create -f memsql-master/PersistentVolumeClaim.yaml
oc create -f memsql-master/BuildConfig.yaml
oc create -f memsql-master/ImageStream.yaml
oc create -f memsql-master/DeploymentConfig.yaml
oc create -f memsql-master/Services.yaml
oc create -f memsql-master/Route.yaml

echo "memsql Child0"
oc create -f memsql-child0/PersistentVolumeClaim.yaml
oc create -f memsql-child0/BuildConfig.yaml
oc create -f memsql-child0/ImageStream.yaml
oc create -f memsql-child0/DeploymentConfig.yaml
oc create -f memsql-child0/Services.yaml

echo "memsql Leaf0"
oc create -f memsql-leaf0/PersistentVolumeClaim.yaml
oc create -f memsql-leaf0/BuildConfig.yaml
oc create -f memsql-leaf0/ImageStream.yaml
oc create -f memsql-leaf0/DeploymentConfig.yaml
oc create -f memsql-leaf0/Services.yaml

echo "memsql Leaf1"
oc create -f memsql-leaf1/PersistentVolumeClaim.yaml
oc create -f memsql-leaf1/BuildConfig.yaml
oc create -f memsql-leaf1/ImageStream.yaml
oc create -f memsql-leaf1/DeploymentConfig.yaml
oc create -f memsql-leaf1/Services.yaml
