FROM keksgesicht/steamcmd

ENV STEAMAPPID  4020
ENV STEAMAPPDIR $HOME/gmod
ENV SVPORT      27015
ENV SVPARAMS    "+gamemode terrortown \
                 +exec server.cfg"

ENV STEAMCSSID  232330
ENV STEAMCSSDIR $HOME/cstrike

USER root
RUN set -x \
 && apt-get update \
 && apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6 \
        lib32tinfo5 \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

USER steam
RUN $STEAMCMDDIR/steamcmd.sh \
        +login anonymous \
        +force_install_dir $STEAMAPPDIR \
        +app_update $STEAMAPPID validate \
        +force_install_dir $STEAMCSSDIR \
        +app_update $STEAMCSSID validate \
        +quit \
 && { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'login anonymous'; \
        echo 'force_install_dir $STEAMAPPDIR'; \
        echo 'app_update $STEAMAPPID'; \
        echo 'quit'; \
    } > $STEAMAPPDIR/steamcmd_update.txt
 && echo '"mountcfg"{"cstrike" "$STEAMCSSDIR/cstrike"}' >> /steam/gmod/garrysmod/cfg/mount.cfg

EXPOSE $SVPORT
WORKDIR $STEAMAPPDIR
VOLUME $STEAMAPPDIR/garrysmod/addons/
       $STEAMAPPDIR/garrysmod/cache/srcds/
       $STEAMAPPDIR/garrysmod/data/
ENTRYPOINT [ "./srcds_run", \
             "-game garrysmod", \
			 "-console", 
			 "-autoupdate -steam_dir $STEAMCMDDIR -steamcmd_script $STEAMAPPDIR/steamcmd_update.txt", \
             "-norestart", \
             "-nohltv", \
             "+hostport $SVPORT", \
             "$SVPARAMS" ]
