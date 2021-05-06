#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Improve the bash history
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check window size and append history
shopt -s checkwinsize
shopt -s histappend
PROMPT_COMMAND='history -a'

# Ignore case on auto-completion
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous on"; fi


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

# Setup and source fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_CTRL_T_COMMAND='find . -type f'
export FZF_ALT_C_COMMAND='find . -type d'
