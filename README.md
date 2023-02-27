# bug-bounty-vps

![Logo](https://img.shields.io/docker/image-size/fonalex45/bounty?style=flat)
![Logo](https://img.shields.io/docker/pulls/fonalex45/bounty?style=flat)
![Publish Docker Image](https://github.com/alexrf45/bug-bounty-vps/actions/workflows/dockerhub.yml/badge.svg?branch=main)

Simple vps for running bug bounty workloads

## Local Container usage:

```bash
$ git clone https://github.com/alexrf45/bug-bounty-vps.git

$ cd bug-bounty-vps/

$ docker build -t bounty:local .

$ cat functions >> .zshrc or .bashrc

$ source ~/.zshrc

$ export NAME=target #substitute target for domain or company

$ mkdir -p $NAME & cd $NAME

$ bounty

```

## VPS

```bash
$ git clone https://github.com/alexrf45/bug-bounty-vps.git

$ ssh-keygen -t rsa -C "bug" -f ~/.ssh/jump

$ cd bug-bounty-vps/vps/live

$ terraform init

$ terraform plan -out=test

$ terraform apply "test"

```

- After 5 minutes, ssh into the VPS: 

```bash

$ terraform output #jot down the public IP address

$ export IP=xxx.xxx.xxx.xxx

$ ssh -i ~/.ssh/jump ubuntu@$IP

# (optional) in the vps launch tmux
$ t test

$ export NAME=target #substitute target for domain or company

$ mkdir -p $NAME & cd $NAME

$ bounty

```
## Recon.sh

```bash
#multiple domains can be specified. please copy, via scp, a amass config.ini w/ api keys to the vps before running

recon.sh -p PROJECTNAME -d DOMAIN
```
