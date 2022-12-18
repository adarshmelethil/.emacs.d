#!/usr/bin/env sh

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd )"

rm "${HOME}/.emacs.d" || :
ln -s "${SCRIPT_DIR}" "${HOME}/.emacs.d"
