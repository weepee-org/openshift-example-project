# openshift-example-project

Example project running:
- static static webserver
- php webserver
- hhvm webserver

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project

```sh
> oc new-project example \
    --description="Examples - static, php, mojo, hhvm, proxy" \
    --display-name="Examples"
```

build static webserver

```sh
> oc create -f static/BuildConfig.yaml
> oc create -f static/ImageStream.yaml
> oc create -f static/DeploymentConfig.yaml
> oc create -f static/Services.yaml
> oc start-build static
```

build php webserver

```sh
> oc create -f php/BuildConfig.yaml
> oc create -f php/ImageStream.yaml
> oc create -f php/DeploymentConfig.yaml
> oc create -f php/Services.yaml
> oc start-build php
```

build mojo webserver

```sh
> oc create -f mojo/BuildConfig.yaml
> oc create -f mojo/ImageStream.yaml
> oc create -f mojo/DeploymentConfig.yaml
> oc create -f mojo/Services.yaml
> oc start-build mojo
```

build hhvm webserver

```sh
> oc create -f hhvm/BuildConfig.yaml
> oc create -f hhvm/ImageStream.yaml
> oc create -f hhvm/DeploymentConfig.yaml
> oc create -f hhvm/Services.yaml
> oc start-build hhvm
```

build proxy server for glueing all above together

```sh
> oc create -f proxy/BuildConfig.yaml
> oc create -f proxy/ImageStream.yaml
> oc create -f proxy/DeploymentConfig.yaml
> oc create -f proxy/Services.yaml
> oc create -f proxy/Route.yaml
> oc start-build proxy
```

#### Modifications for integrating in a private repository

create an ssh deploy key without passphrase
```sh
> ssh-keygen -f ~/.ssh/openshift-my-static-site
```

```sh
> oc secrets new-sshauth openshift-my-static-site --ssh-privatekey=/home/joeri/.ssh/openshift-my-static-site
> oc secrets add serviceaccount/builder secrets/openshift-my-static-site
```

Update the BuildConfig
(Modify and Append BuildConfig-Secrets.yaml.template to your Buildconfig)
(Remove old BuildConfig first !)

```sh
> oc delete -f Buildconfig.yaml
> oc create -f BuildConfig.yaml
```
Add your key to the deploy keys of you repository on GitHub

```sh
> cat ~/.ssh/openshift-my-static-site.pub
```

#### Route-production.yml

Routes to a production hostname

```sh
> oc create -f Route-production.yaml
```

#### WebHooks

You can find the (github and generic) webhook in the openshift control pannel ! (Browse - Builds)
You can copy the url to clipboard and paste it in Github webhook url (handy for rolling updates)

#### Updating from branches

You can trigger on different Branches just modify your BuildConfig

```yaml
source:
  git:
    ref: release
    uri: https://github.com/weepee-org/openshift-example-project.git
  contextDir: php/
  type: Git
```
