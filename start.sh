#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

INIT_SCRIPT="${SCRIPT_DIR}/init.el"
EARLY_INIT_SCRIPT="${SCRIPT_DIR}/early-init.el"

exec emacs \
    --no-init-file \
    --load "${INIT_SCRIPT}" # --load "${EARLY_INIT_SCRIPT}" \
