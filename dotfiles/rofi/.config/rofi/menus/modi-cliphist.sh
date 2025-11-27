#!/usr/bin/env bash

if [ -z "$1" ]; then
    cliphist list | grep -viP "\[\[\s+binary\sdata\s\d+\s(K|M)i?B\spng\s\d+x\d+\s+\]\]"
else
    cliphist decode <<<"$1" | wl-copy
fi
