#!/bin/sh

run_inside="'ZDOTDIR=${HOME}/.i3/scratchpad zsh'"

while true; do
    # not using urxvtc here, as we're relying on the process to run
    # until either
    #
    # * it gets detached (eg by ^Ad)
    # * it terminates (because someone killed all windows)
    #
    # in any case, we try to reattach to the session, or, if that fails,
    # create a new one.
    if hash urxvt 2>/dev/null; then
      urxvt -name todo -e sh -c "tmux attach -t todo || tmux new-session -s todo $run_inside ';' set-option -t todo default-command $run_inside"
    else
      sudo apt-get install rxvt-unicode
    fi
done
