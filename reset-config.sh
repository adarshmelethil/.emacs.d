#!/usr/bin/env sh

rm "${HOME}/.emacs.d" || :
ln -s "${HOME}/.emacs.d.doom" "${HOME}/.emacs.d"
