#!/bin/bash
set -e

if [ "$1" = 'jupyter-notebook' ]; then
    ##################### Handle SIGTERM #####################
    function _term() {
        printf "%s\n" "Caught terminate signal!"

        kill -SIGTERM $child
        exit 0
    }

    trap _term SIGHUP SIGINT SIGTERM SIGQUIT

    ##################### Start application #####################
    # default password: coclab@123
    DEFAULT_PASSWORD_HASH='sha1:f55d2bbbb930:36a17bf90ec1594e0e9b580c923b420ff9f575fe'
    : ${PASSWORD_HASH:=${DEFAULT_PASSWORD_HASH}}

    jupyter notebook --ip=0.0.0.0 --port=9999 --no-browser --NotebookApp.password=${PASSWORD_HASH} &

    child=$!
    wait "$child"
fi

exec "$@"
