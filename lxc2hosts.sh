#!/bin/bash

function checkRoot() {
  ME=$(whoami)
  if [ ! "root" == $ME ]; then
    echo "you must be root!"
    echo "you are $ME. you rock, sure, but root rocks more ;)"
    echo ""
    exit 1
  fi
}

checkRoot

if ! command -v jq &>/dev/null; then
  echo "jq could not be found"
  echo "run"
  echo "sudo apt install jq"
  echo "to install"
  exit 1
fi

echo "" >>/etc/hosts
echo "#######" >>/etc/hosts
echo "" >>/etc/hosts
lxc list --format=json volatile.last_state.power=RUNNING | jq -r '.[] | .state.network.eth0.addresses[0].address + " " +  .name' >>/etc/hosts

exit 0
