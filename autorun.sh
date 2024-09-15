#!/bin/bash

echo -n "Wallet name: "
read wallet

echo -n "Inscribe filename: "
read filename

echo -n "fee-rate: "
read feeRate

echo -n "Destination address: "
read destination

command="ord --config config wallet --name $wallet inscribe --fee-rate $feeRate --file $filename --destination $destination"

while true; do
  $command

  if [ $? -ne 0 ]; then
    echo "命令执行失败，退出循环"
    exit 1
  fi
    sleep 1
  done

