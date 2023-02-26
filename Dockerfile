FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y sudo

RUN groupadd --gid 1000 bounty \
    && useradd --home-dir /home/bounty --create-home --uid 1000 \
      --gid 1000 --shell /bin/bash --skel /dev/null bounty

RUN chown -R bounty:bounty /home/bounty/

RUN echo bounty:bounty | chpasswd

RUN usermod -aG sudo bounty

RUN echo 'bounty  ALL=(ALL) NOPASSWD:ALL' >>  /etc/sudoers.d/bounty

WORKDIR /home/bounty/

USER bounty

ADD resources /home/bounty/resources

RUN sudo chown -R bounty:bounty /home/bounty/resources

RUN mkdir .logs && mkdir .local && mkdir wordlists \
	&& cp /home/bounty/resources/wordlists/onelistforallmicro.txt /home/bounty/wordlists/onelistforallmicro.txt \
  && cp /home/bounty/resources/wordlists/onelistforallshort.txt /home/bounty/wordlists/onelistforallshort.txt \
  && cp /home/bounty/resources/tmux.conf /home/bounty/.tmux.conf \
  && cp /home/bounty/resources/recon.sh /home/bounty/.local/recon.sh \
  && chmod +x /home/bounty/.local/recon.sh

ADD sources /home/bounty/sources

RUN sudo chown -R bounty:bounty /home/bounty/sources

RUN sudo chmod +x /home/bounty/sources/packages.sh && \
	/home/bounty/sources/packages.sh 

RUN sudo chmod +x /home/bounty/sources/go.sh \
	&& /home/bounty/sources/go.sh install_go

COPY sources/hakrawler /home/bounty/.local/bin/hakrawler

RUN sudo chmod +x /home/bounty/.local/bin/hakrawler

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" \
	--unattended

RUN cp /home/bounty/resources/zsh/zshrc /home/bounty/.zshrc

RUN cp /home/bounty/resources/zsh/ka-tet.zsh-theme /home/bounty/.oh-my-zsh/themes/. \
	&& cp /home/bounty/resources/zsh/bounty_history /home/bounty/.bounty_history

RUN git clone https://github.com/zsh-users/zsh-autosuggestions \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

RUN sudo rm -rf /home/bounty/resources && sudo rm -rf /home/bounty/sources

USER bounty

RUN zsh
