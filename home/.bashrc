#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# apply the aliases and color :)
alias abort='sudo pacman -Qtdq | sudo pacman -Rns -'
alias yeet='sudo pacman -Rns'
alias ls='ls --color=auto'
alias mv='mv -i'
PS1="\[\033[01;35m\][\[\033[01;32m\]\u@\h \[\033[01;34m\]\W\[\033[01;35m\]]\[\033[00m\]\$ "
eval "$(dircolors)"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Source the ranger_cd script
. /usr/share/doc/ranger/examples/shell_automatic_cd.sh

# Source the wal theme for terminals and TTYs
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

