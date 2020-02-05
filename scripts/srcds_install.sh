#!/bin/bash

if [ -n "$VALIDATE" ]; then
	validate="validate"
fi
cd $STEAMCMDDIR
./steamcmd.sh \
	+login anonymous \
	+force_install_dir $STEAMAPPDIR \
	+app_update $STEAMAPPID $validate \
	+quit
