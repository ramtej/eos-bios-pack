#!/bin/bash

# `boot_node` hook
# $1 genesis JSON
# $2 ephemeral public key
# $3 ephemeral private key
#
# This process must not BLOCK.

# load env config
source ../config/hook_env.sh

echo "Removing old nodeos data/config/genesis/log"
rm -rf $NODEOS_WD
mkdir $NODEOS_WD

echo "Generating genesis.json"
echo $1 > $NODEOS_WD/genesis.json

echo "Generating nodeos config"
cp ../config/base_config.ini $NODEOS_WD/config.ini
echo "producer-name = eosio" >> $NODEOS_WD/config.ini
echo "enable-stale-production = true" >> $NODEOS_WD/config.ini
echo "private-key = [\"$2\",\"$3\"]" >> $NODEOS_WD/config.ini

echo "Starting nodeos ..."
$NODEOS_BIN --data-dir $NODEOS_WD --genesis-json $NODEOS_WD/genesis.json --config-dir $NODEOS_WD 2> $NODEOS_WD/nodeos.log &

echo "Waiting 3 secs for nodeos to launch"
sleep 3

echo "Hit ENTER to continue"
read
