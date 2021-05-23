#!/usr/bin/env bash

# contains fzf scripts, mainly from https://github.com/junegunn/fzf/wiki/examples

# cd to sub directory
cdd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
    }

# cdp - including hidden directories
cdda() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# todo: look for more


