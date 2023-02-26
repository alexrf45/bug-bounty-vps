#!/bin/bash

function base() {
  sudo apt-get install -y wget curl man git zsh \
	tmux ruby ruby-dev vim nano p7zip-full \
	djvulibre-bin python3-pip libpcap-dev jq figlet lolcat
}

base

function network() {
  sudo apt-get install -y netcat-traditional rlwrap nmap \
	netdiscover masscan dnsutils onesixtyone braa tcpdump \
	ftp telnet swaks snmpcheck snmpcheck snmp-mibs-downloader \
	iputils-ping iproute2 proxychains
}

network

function web () {
  sudo apt-get install -y whatweb ffuf gobuster \
	exiftool default-mysql-client hurl postgresql arjun \
	crunch nuclei
}

web

function lolcat_gem() {
	sudo gem install lolcat
}

lolcat_gem
