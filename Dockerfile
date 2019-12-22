FROM debian:jessie

ENV HOME        /home/steam
ENV STEAMCMDDIR $HOME/steamcmd

RUN set -x \
 && apt-get update \
 && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        ca-certificates \
        lib32gcc1 \
 && useradd -m steam \
 && su steam -c \
        "mkdir -p $STEAMCMDDIR \
        && cd $STEAMCMDDIR \
        && wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - \
        && ./steamcmd.sh +login anonymous +quit" \
 && apt-get remove --purge -y \
        wget \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

USER steam
WORKDIR $STEAMCMDDIR
ENTRYPOINT [ "./steamcmd.sh", \
             "+login anonymous" ]
