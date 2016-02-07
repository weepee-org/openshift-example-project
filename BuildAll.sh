#!/bin/bash

echo "static"
oc create -f static/BuildConfig.yaml
oc create -f static/ImageStream.yaml
oc create -f static/DeploymentConfig.yaml
oc create -f static/Route.yaml
oc create -f static/Services.yaml
oc start-build static

echo "php"
oc create -f php/BuildConfig.yaml
oc create -f php/ImageStream.yaml
oc create -f php/DeploymentConfig.yaml
oc create -f php/Route.yaml
oc create -f php/Services.yaml
oc start-build php

