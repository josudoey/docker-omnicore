#!/usr/bin/env bash
set -e

mkdir -p ${DATA_DIR}

if [[ "$1" == "bitcoin-tx" || "$1" == "omnicore-cli" || "$1" == "omnicore-qt" || "$1" == "omnicored" ]]; then

    if [[ ! -s "${DATA_DIR}/bitcoin.conf" ]]; then
        cat <<EOF > "${DATA_DIR}/bitcoin.conf"
server=1
txindex=1
printtoconsole=1
omnilogfile=
logtimestamps=1
rpcallowip=${RPCALLOWIP}
rpcuser=${RPCUSER}
rpcpassword=${RPCPASSWORD}
EOF
    fi
fi

exec "$@"