#!/bin/bash

########################################
# My first bug bounty script. I was looking to combine my normal workflow into a portable script.
# You will need to configure your amass config (API keys, etc) before running the script. Running amass with no API keys is not recommended.
########################################

project=$1
domain=$2

RED="31"
BOLDRED="\e[1;${RED}m"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
YELLOW="33"
BOLDYELLOW="\e[1;${YELLOW}m"
ENDCOLOR="\e[0m"

while getopts "p:d:" opt
do
   case "$opt" in
      p ) project="$OPTARG" ;;
      d ) domain="$OPTARG" ;;
      ? ) Usage ;;
   esac
done

Usage() {
    figlet recon.sh | lolcat
    echo -e "Usage: ./recon.sh -p PROJECT_NAME -d domain\n"
    echo -e "-p Project name or target"
    echo -e "-d root domain/target -- multiple domains can be specified\n"
    exit 1
}

if [ -z "$project" ]
then
   echo $red"[-]" "Project name required";
   Usage
fi

if [ -z "$domain" ]
then
   echo $red"[-]" "Domain required";
   Usage
fi

if [ -d "$project" ]; then
    rm -rf $project && mkdir $project && cd $project
    else
    mkdir $project && cd $project
fi

main_banner() {
    figlet recon.sh | lolcat
}


tool_banner() {
    echo -e "${BOLDGREEN}+------------------------------------------+"
    printf "| %-40s |\n" "`date`"
    echo -e "|                                          |"
    printf "${BOLDGREEN}|`tput bold` %-40s `tput sgr0`${BOLDGREEN}|\n" "$@"
    echo -e "${BOLDGREEN}+------------------------------------------+"
}

amass_run () {
    echo -e "${BOLDRED}gathering intel on $domain ${ENDCOLOR}\n"
    amass intel -d $domain -whois -o whois.txt
    echo -e "${BOLDGREEN}Amass intel complete${ENDCOLOR}\n"
    echo -e "${BOLDRED}searching for $domain ${ENDCOLOR}\n"
    amass enum -config ~/.config/amass/config.ini -o domains.txt -d $domain
    echo -e "${BOLDGREEN}Amass subdomain enum complete${ENDCOLOR}\n"
    echo -e "${BOLDRED}resolving IP addresses for $project...${ENDCOLOR}"
    amass enum -config ~/.config/amass/config.ini -o ip.txt -ipv4 -d $domain
    echo -e "${BOLDGREEN}Amass IP enum complete${ENDCOLOR}\n"
}

waybackurls() {
  cat domains.txt | waybackurls > urls.txt
}

http_probe () {
    echo -e "${BOLDRED}searching for live hosts on $project...${ENDCOLOR}"
    cat domains.txt | httprobe > live-hosts.txt
}

naabu_httpx_live () {
  echo -e "${BOLDRED}probing hosts on $project...${ENDCOLOR}"
  naabu -list live-hosts.txt | http-x -list live-hosts.txt -silent -probe -tech-detect -status-code > probed-hosts.txt
}

httpx_live () {
    echo -e "${BOLDRED} probing hosts with httpx...${ENDCOLOR}"
    http-x -list live-hosts.txt -silent -probe -tech-detect -status-code > probed-hosts.txt

}
file_format(){
    echo -e "${BOLDYELLOW}Formatting httpx results${ENDCOLOR}\n"
    cat probed-hosts.txt | grep 'SUCCESS' | cut -d '[' -f 1 > targets.txt

}

hakrawler() {
  echo -e "${BOLDRED} probing hosts with hakrawler...${ENDCOLOR}"
  cat targets.txt | hakrawler -d 3 > endpoints.txt
}

spider_directories() {
    echo -e "${BOLDRED}spidering directories${ENDCOLOR}"
    for URL in $(<targets.txt); do ( ffuf -u "${URL}/FUZZ" \
    -w /home/bounty/wordlists/onelistforallshort.txt \
    -c -t 5 -p 0.3 -ac -mc 200,302,403,422,404,500,503,502 -o $NAME-ffuf.json -of json); done
}

nuclei_tool () {
    echo -e "${BOLDRED}running nuclei on $project${ENDCOLOR}"
    nuclei -t cves/ -t technologies/ -l live-hosts.txt -o nuclei-results
}

main_banner
tool_banner "Running Amass"
amass_run
tool_banner "Amass enumeration complete"
tool_banner "Running waybackurls"
waybackurls
tool_banner "Running httprobe"
http_probe
tool_banner "Httprobe complete"
tool_banner "Running naabu & httpx"
naabu_httpx_live
tool_banner "Formatting httpx results"
file_format
tool_banner "Httpx complete"
tool_banner "Running hakrawler"
hakrawler
tool_banner "hakrawler complete"
tool_banner "Running spider"
spider_directories
tool_banner "Spider complete"
tool_banner "Running Nuclei"
nuclei_tool
tool_banner "Finished"
