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
