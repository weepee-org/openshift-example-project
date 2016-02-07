#!/bin/bash

# generate uniq string
SECRET=`uuidgen | perl -pe 's/-//g'`

# create Buildconfig if not exists
if [ -f 'BuildConfig.yaml' ];
then
  echo "BuildConfig.yaml exists. Not Updating"
else
  cp BuildConfig.yaml.template BuildConfig.yaml
  perl -i -pe "s/GENWEBHOOKSECRET/$SECRET/g" BuildConfig.yaml
  echo "BuildConfig.yaml" > .gitignore
  git add .gitignore
  echo "BuildConfig.yaml created".
fi
