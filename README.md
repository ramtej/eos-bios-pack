# eos-bios-pack
EOS.IO BIOS Program, to kickstart a new network. Quick start pack!

THIS IS ONLY A DEMO FOR EASY START.

FIND MORE DETAILED INSTRUCTIONS FROM THE EOS-BIOS OFFICIAL REPO:

https://github.com/eoscanada/eos-bios

THIS VERSION IS TESTED IN CENTOS ONLY, BUT SHOULD WORK IN ALL LINUX DIST.


## HOW TO GO TO THE NEXT STAGE

1. Copy the template from the current SEED stage

run "cp -r stage5 stage6"


2. Understand what you need to change

run "diff -r stage4/config stage5/config"


3. Modify the new TARGET stage config

make changes to the stage6/config/*


4. Publish your TARGET config to the SEED stage network

run "publish.sh"


5. Check if your new TARGET config is published successufully

run "eos-bios.sh list"


6. Orchestrate & sleep

run "orchestrate.sh"

eos-bios will connect to the SEED network, and waiting for the block height, then BIOS BOOT or JOIN the new TARGET network automatically.
