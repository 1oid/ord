#!/bin/bash


echo -n "Input REDB Download URL: "
read DOWNLOAD_URL

echo -n "Input RPC Node IP: "
read RPC_NODE

wget https://github.com/1oid/ord/releases/download/v2.0/ord-v2.0-x86_64-unknown-linux-gnu.tar.gz -O ord-server.tar.gz
tar -zxvf ord-server.tar.gz
mv ord-v2.0/ord /usr/bin
wget "$DOWNLOAD_URL/index.redb" -O /root/ord-server/data/fractal-mainnet/index.redb
cd /root/ord-server/

cat > config <<EOF
bitcoin_rpc_url: http://$RPC_NODE:8332
bitcoin_rpc_username: bitcoin
bitcoin_rpc_password: opcatAwesome
data_dir: /root/ord-server/data
chain: fractal-mainnet
first_inscription_height: 0
EOF

ord --config config index update
screen -dm -S ord -L -t ord ord --config config server

echo "Install Finished. Run 'screen -r' show index update progress."

