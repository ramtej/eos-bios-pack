#!/bin/bash

# `join_network` hook:
# $1 = genesis_json
# $2 = p2p_address_statements like "p2p-peer-address = 1.2.3.4\np2p-peer-address=2.3.4.5"
# $3 = p2p_addresses to connect to, split by comma
# $4 = producer-name statements, like: "producer-name = hello\nproducer-name = hello.a"
#      You will have many only when joining a net with less than 21 producers.
# $5 = producer-name you should handle, split by comma

# load env config
source ../config/hook_env.sh

echo "Removing old nodeos data/config/genesis/log"
rm -rf $NODEOS_WD
mkdir $NODEOS_WD

echo "Generating genesis.json"
echo $1
echo $1 > $NODEOS_WD/genesis.json

# Your base_config.ini shouldn't contain any `producer-name` nor `private-key`
# nor `enable-stale-production` statements.
echo "Generating nodeos config"
cp ../config/base_config.ini $NODEOS_WD/config.ini
echo "$2" >> $NODEOS_WD/config.ini
echo "$4" >> $NODEOS_WD/config.ini
echo "private-key = [\"$PUBKEY\",\"$PRIVKEY\"]" >> $NODEOS_WD/config.ini

echo "Starting nodeos ..."
$NODEOS_BIN --data-dir $NODEOS_WD --genesis-json $NODEOS_WD/genesis.json --config-dir $NODEOS_WD 2> $NODEOS_WD/nodeos.log &

echo "Waiting 3 secs for nodeos to launch"
sleep 3

echo "Hit ENTER to continue"
read
