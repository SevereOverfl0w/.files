#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
while true; do
        sh $DIR/bar.sh
        # ~/bin/pxi ./bar.pxi
        sleep 1;
done
