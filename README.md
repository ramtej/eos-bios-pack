# eos-bios-pack

This is only a example of **EOS-BIOS**, to help you quick understand how it works. Thanks for the great work of **EOSCANADA** who created **EOS-BIOS**:
https://github.com/eoscanada/eos-bios

THIS VERSION IS TESTED WITH CENTOS ONLY. IT SHOULD WORK IN ALL LINUX DIST.

### JOINS US:
On Telegram through this invite link: [https://t.me/joinchat/GSUv1UaI5QIuifHZs8k_eA](https://t.me/joinchat/GSUv1UaI5QIuifHZs8k_eA) (EOSIO BIOS Boot channel)

### HOW TO BIOS BOOT A EOS NETWORK
We have a network STAGE-5(SEED) running. And we want to orchestrate start a new network STAGE-6(TARGET). Here is what everyone needs to do for a simplified example.

#### 0. Git clone this project
```sh
$ git clone https://github.com/eosflare/eos-bios-pack.git
```

#### 1. Create a new stage6 dir from stage5 as template
```sh
$ cd eos-bios-pack
$ cp -r stage5 stage6
```

#### 2. Understand what you need to change to the config files
```sh
$ diff -r stage4/config stage5/config
```
The stage4 dir is useless in this procedure. It just helps you to understand what you need to change to the config files.

#### 3. Modify the new STAGE-6(TARGET) stage config
Make changes to the files in **stage6/config**
Don't forget to change the **NODEOS_BIN** to the **hook_env.sh**
We put the **nodeos** binary file in "~/bin" by default.

#### 4. Set your own account and keys
```sh
$ cleos create key
```
Public key: EOS6EoqeV7vSMfsfNHPWEEWAsTgffMM2hCZomGxS16G3AwS1VSvaL
Private key: 5JdsZotzQ9bqX8KdqA4ERHjcByhKtx24Fxfv4D3sqycoe3yyC4H

Update your keys to the **privkeys.keys** and **hook_env.sh**.

Update your **seed_network_account_name** and **target_account_name** and the keys in the **my_discovery_file.yaml** file to the user name your want to use.

Then ask someone in the telegram group to invite you to the STAGE-5(SEED) network. They will run eos-bios invite [youraccount] [your key] to create a account with your key in the STAGE-5(SEED) network.


#### 5. Publish your STAGE-6(TARGET) config to the STAGE-5(SEED) stage network
```sh
$ cd stage6
$ ./publish.sh
```
Your **my_discovery_file.yaml** should be published to the STAGE-5(SEED) network (**seed_network_http_address**) using the account (**seed_network_account_name**).

The result should likes this.
> Updating network graph
> Done.

If you encounter errors like, if means your **seed_network_account_name** does not exist in the seed network, or your **privkeys.keys** is not correct. Check your config files. Or check if your account exists in the seed network.
>error: GetRequiredKeys: status code=401, body={"code":401,"message":"UnAuthorized","error":{"code":3030002,"name":"tx_missing_sigs","what":"signatures do not satisfy declared authorizations","details":[{"message":"transaction declares authority '{\"actor\":\"eosflareioxx\",\"permission\":\"active\"}', but does not have signatures for it.","file":"chain_controller.cpp","line_number":972,"method":"get_required_keys"}]}}


#### 6. Check if your new STAGE-6(TARGET) config is published successufully
```sh
$ ./eos-bios.sh list
```
The result lists all the disco files, that has been published by you and other BPs, in the STAGE-5(SEED) network
>List of all accounts that have published a discovery file:
> -- eosflareio
>-- eosindia
>-- eosiosg
>-- eosmama
>-- eoscanadacom

#### 7. Run orchestrate & sit back
```sh
$ ./orchestrate.sh
```
eos-bios is going to connect to the STAGE-5(SEED) network, and waiting for the block height, then bios "BOOT" or "JOIN" the new STAGE-6(TARGET) network automatically.

It is normal to see error messages like this, because we haven't reached the block height.
>couldn't fetch seed network block: status code=500, body={"code":500,"message":"Internal Service Error","error":{"code":3110000,"name":"unknown_block_exception","what":"unknown block","details":[{"message":"Could not find block: 75000","file":"chain_plugin.cpp","line_number":391,"method":"get_block"}]}}

