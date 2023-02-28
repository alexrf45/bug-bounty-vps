#!/bin/bash

#copies config.ini w/ api keys to vps
scp config.ini ubuntu@$IP:/home/ubuntu/.local/config.ini

#sets the folder name by passing a local variable as a remote variable then ssh into the created folder. saves a few steps. I'd love 
#to call the container function too but I will save that for another time
export NAME=$1 ; ssh -t -i ~/.ssh/jump ubuntu@$IP "export NAME=$NAME && mkdir -p $NAME && cd $NAME ; /usr/bin/zsh"



