#!/bin/bash

cd $STEAMCMDDIR
if ! [ -x ./steamcmd.sh ]; then
	wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf -
	./steamcmd.sh \
		+login anonymous \
		+quit
fi
