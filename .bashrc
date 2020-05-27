#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# apply the color :)
alias ls='ls --color=auto'
PS1="\[\033[01;35m\][\[\033[01;32m\]\u@\h \[\033[01;34m\]\W\[\033[01;35m\]]\[\033[00m\]\$ "
eval "$(dircolors)"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
