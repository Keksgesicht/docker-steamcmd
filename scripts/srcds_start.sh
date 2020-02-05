#!/bin/bash

cd $STEAMAPPDIR
./srcds_run \
	-game $GAMENAME \
	$SVPARAMS \
	-norestart \
	+hostport $SVPORT
