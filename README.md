# openshift-my-static-site

Example project running:
- static static webserver
- php webserver
- hhvm webserver

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project

```sh
> oc new-project example \
    --description="Project - static, php, hhvm" \
    --display-name="Static PHP hhvm"
```

build static webserver

```sh
> oc create -f static/BuildConfig.yaml
> oc create -f static/ImageStream.yaml
> oc create -f static/DeploymentConfig.yaml
> oc create -f static/Route.yaml
> oc create -f static/Services.yaml
> oc start-build static
```

#### Addoption for a private repository

create an ssh deploy key without passphrase
```sh
> ssh-keygen -f ~/.ssh/openshift-my-static-site
```

```sh
> oc secrets new-sshauth openshift-my-static-site --ssh-privatekey=/home/joeri/.ssh/openshift-my-static-site
> oc secrets add serviceaccount/builder secrets/openshift-my-static-site
```

Clone the repository
```sh
> git clone git@github.com:ure/openshift-my-static-site.git
> cd openshift-my-static-site
```

Create the BuildConfig

```sh
> ./genwebhooksecret.sh
> oc create -f BuildConfig.yaml
```
Add your key to the deploy keys of you repository on GitHub

```sh
> cat ~/.ssh/openshift-my-static-site.pub
```

Deploy from private git repository

```sh
> oc new-app .
```

#### Route-production.yml

Routes to a production hostname

```sh
> oc create -f Route-production.yaml
```

#### WebHooks

You can find the (github and generic) webhook in the openshift control pannel ! (Browse - Builds)
You can copy the url to clipboard and paste it in Github webhook url (handy for rolling updates)
