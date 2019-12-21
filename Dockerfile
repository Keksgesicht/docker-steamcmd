FROM i386/debian:jessie

ENV HOME		/home/steam
ENV STEAMCMDDIR	$HOME/steamcmd
ENV GAMESRVDIR	$HOME/gamesrv
ENV DOCKERGO	$HOME/docker-scripts
ENV SVPORT		27015

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		libtinfo5 \
		libtcmalloc-minimal4 \
		libstdc++6 \
		libgcc1 \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*
	
RUN useradd -m steam \
	&& su steam -c \
		"mkdir -p $STEAMCMDDIR \
		&& cd $STEAMCMDDIR \
		&& wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -"

EXPOSE $SVPORT
USER steam
WORKDIR $STEAMCMDDIR
VOLUME $STEAMCMDDIR
