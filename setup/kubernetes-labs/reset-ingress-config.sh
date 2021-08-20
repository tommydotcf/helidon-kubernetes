#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, you must provide the External IP address of the ingress controler service"
    exit -1 
fi
if [ $# -eq 1 ]
  then
    echo Updating the ingress config to remove $1 as the External IP address.
    read -p "Proceed ? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
      then
        echo OK, exiting
        exit 1
    fi
  else
    echo "Skipping confirmation"
fi

echo Updating ingress removing $1 as the external IP address
# echo command is "s/store.$1.nip.io/store.<External IP>.nip.io>/"
cat ingressConfig.yaml | sed -e "s/store.$1.nip.io/store.<External IP>.nip.io/" > ingressConfig.yaml.tmp
rm ingressConfig.yaml
mv ingressConfig.yaml.tmp ingressConfig.yaml