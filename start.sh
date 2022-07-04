#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

INIT_SCRIPT="${SCRIPT_DIR}/init.el"

exec emacs \
    --no-init-file \
    --debug-init \
    --load "${INIT_SCRIPT}"
