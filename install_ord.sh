#!/bin/bash


echo -n "Input REDB Download URL: "
read DOWNLOAD_URL

echo -n "Input RPC Node IP: "
read RPC_NODE

currentPath=$PWD
mkdir $currentPath/ord-server/data/fractal-mainnet/

wget https://github.com/1oid/ord/releases/download/v2.0/ord-v2.0-x86_64-unknown-linux-gnu.tar.gz -O ord-server.tar.gz
tar -zxvf ord-server.tar.gz
sudo mv ord-v2.0/ord /usr/bin

echo "DOWNLOAD: $DOWNLOAD_URL/index.redb"
wget "$DOWNLOAD_URL/index.redb" -O $currentPath/ord-server/data/fractal-mainnet/index.redb
cd $currentPath/ord-server/

cat > config <<EOF
bitcoin_rpc_url: http://$RPC_NODE:8332
bitcoin_rpc_username: bitcoin
bitcoin_rpc_password: opcatAwesome
data_dir: $currentPath/ord-server/data
chain: fractal-mainnet
first_inscription_height: 0
EOF

ord --config config index update
screen -dm -S ord -L -t ord ord --config config server

echo "Install Finished. Run 'screen -r' show index update progress."

