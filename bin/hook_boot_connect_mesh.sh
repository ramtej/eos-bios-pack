#!/bin/bash

# `boot_connect_mesh.sh` hook
# $1 p2p-peer-address statements (like the `join_network` hook)
# $2 comma-separated peer address list
#
# This hook is called when you 'eos-bios boot' or are seleted as BIOS
# Boot in an orchestrated launch.
#
# It should connect your boot node

# load env config
source ../config/hook_env.sh

echo "Adding p2p-peer-address'es to config.ini"

echo "$1" >> $NODEOS_WD/config.ini


echo "Restarting boot node"
echo "TODO: TERMINATE NODEOS"
echo "!!! YOU NEED TO TERMINATE IT MANUALLY, BY NOW"
echo "press ENTER after you terminated nodeos"
read


echo "Starting nodeos ..."
$NODEOS_BIN --data-dir $NODEOS_WD --genesis-json $NODEOS_WD/genesis.json --config-dir $NODEOS_WD 2> $NODEOS_WD/nodeos.log &

sleep 2
