#!/bin/bash -euxo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

INIT_SCRIPT="${SCRIPT_DIR}/init.el"
EARLY_INIT_SCRIPT="${SCRIPT_DIR}/early-init.el"

# --load "${EARLY_INIT_SCRIPT}" \
exec emacs \
    --no-init-file \
    --load "${INIT_SCRIPT}"  \
    "$@"
