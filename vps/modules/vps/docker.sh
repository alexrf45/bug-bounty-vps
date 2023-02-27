#! /bin/bash

apt-get update && apt-get install -y tmux zsh jq wget curl

curl -fsSL https://get.docker.com -o get-docker.sh

sh get-docker.sh

usermod -aG docker ubuntu

docker pull fonalex45/bounty:latest

sudo -u ubuntu -i <<'EOF'

sudo apt update

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

wget https://raw.githubusercontent.com/alexrf45/bug-bounty-vps/main/resources/zsh/ka-tet.zsh-theme -O ~/.oh-my-zsh/themes/ka-tet.zsh-theme

wget https://raw.githubusercontent.com/alexrf45/bug-bounty-vps/main/resources/zsh/zshrc_example -O /home/ubuntu/.zshrc

wget https://raw.githubusercontent.com/alexrf45/bug-bounty-vps/main/resources/tmux.conf -O /home/ubuntu/.tmux.conf

mkdir -p /home/ubuntu/.tmux 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux/tmux-themepack

cp .zshrc .zlogin && touch ~/.hushlogin

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

mkdir -p /home/ubuntu/.logs

EOF

chsh -s /usr/bin/zsh ubuntu

reboot

