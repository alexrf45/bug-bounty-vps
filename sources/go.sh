#!/bin/bash

function install_go() {
    wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && sudo tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz \
    && rm go1.20.1.linux-amd64.tar.gz
}

function waybackurls_install() {
    wget -q -O waybackurls.tgz https://github.com/tomnomnom/waybackurls/releases/download/v0.1.0/waybackurls-linux-amd64-0.1.0.tgz \
    && gunzip waybackurls.tgz \
    && tar -C /home/bounty/.local/ -xf waybackurls.tar \
    && chmod +x /home/bounty/.local/waybackurls \
    && rm /home/bounty/waybackurls.tar \
    
}

function httpx_install() {
    wget -q https://github.com/projectdiscovery/httpx/releases/download/v1.2.5/httpx_1.2.5_linux_amd64.zip \
    && unzip httpx_1.2.5_linux_amd64.zip -d ./httpx \
    && rm httpx_1.2.5_linux_amd64.zip \
    && mv httpx/httpx /home/bounty/.local/http-x \
    && rm -r httpx/
}


function amass() {
  wget -q https://github.com/OWASP/Amass/releases/download/v3.21.2/amass_linux_amd64.zip \
  && unzip amass_linux_amd64.zip \
  && rm amass_linux_amd64.zip \
  && mv amass_linux_amd64/amass /home/bounty/.local/amass \
  && chmod +x /home/bounty/.local/amass \
  && rm -r amass_linux_amd64/
}

function httprobe() {
  wget -q https://github.com/tomnomnom/httprobe/releases/download/v0.2/httprobe-linux-amd64-0.2.tgz \
  && gunzip httprobe-linux-amd64-0.2.tgz \
  && tar -C /home/bounty/.local/ -xf httprobe-linux-amd64-0.2.tar \
  && chmod +x /home/bounty/.local/httprobe \
  && rm /home/bounty/httprobe-linux-amd64-0.2.tar
}

function naabu(){
  wget -q https://github.com/projectdiscovery/naabu/releases/download/v2.1.2/naabu_2.1.2_linux_amd64.zip \
  && unzip naabu_2.1.2_linux_amd64.zip -d ./naabu \
  && rm naabu_2.1.2_linux_amd64.zip \
  && mv naabu/naabu /home/bounty/.local/naabu \
  && rm -r naabu
}

function go-dorks() {
  wget -q https://github.com/dwisiswant0/go-dork/releases/download/v1.0.2/go-dork_1.0.2_linux_amd64 -O go-dork \
  && mv go-dork /home/bounty/.local/go-dork \
  && chmod +x /home/bounty/.local/go-dork
}

install_go
waybackurls_install
httpx_install
amass
httprobe
naabu
go-dorks
