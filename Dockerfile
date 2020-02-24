FROM debian:oldstable

ENV UID         99
ENV GID         100
ENV HOME        /home/steam

ENV SCRIPTS     $HOME/scripts
ENV STEAMCMDDIR $HOME/steamcmd
ENV STEAMAPPDIR $HOME/library

ENV STEAMAPPID  4020
ENV GAMENAME    garrysmod

ENV SVPORT      27015
ENV SVPARAMS    "+exec server.cfg"

RUN set -x \
 && apt-get update \
 && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        ca-certificates \
        lib32gcc1 \
        lib32stdc++6 \
        lib32tinfo5 \
 && useradd --uid $UID --gid $GID -m steam \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

ADD [--chown=$UID:$GID] scripts/ $SCRIPTS
RUN mkdir -p $STEAMCMDDIR \
             $STEAMAPPDIR \
 && chmod +x -R $SCRIPTS \
 && chown $UID:$GID -R $HOME
 
EXPOSE $SVPORT/udp
VOLUME $STEAMCMDDIR \
       $STEAMAPPDIR

USER steam
WORKDIR $SCRIPTS
ENTRYPOINT ./cmd_download.sh \
        && ./srcds_install.sh \
        && ./srcds_start.sh
