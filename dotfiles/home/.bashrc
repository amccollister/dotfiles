#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Improve the bash history
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check window size and append history
shopt -s autocd
shopt -s checkwinsize
shopt -s histappend
PROMPT_COMMAND='history -a'

# Ignore case on auto-completion
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous on"; fi

# Protect files from >
set -o noclobber

# apply the aliases and color :)
alias abort='sudo pacman -Qtdq | sudo pacman -Rns -'
alias ls='ls --color=auto'
alias grep='grep --color'
alias mv='mv -i'
PS1="\[\033[01;35m\][\[\033[01;32m\]\u@\h \[\033[01;34m\]\W\[\033[01;35m\]]\[\033[00m\]\$ "
eval "$(dircolors)"

# make discord suck less
alias discord='discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy'

# define functions
pacfind(){ pacman -Sl | awk '{print $2($4=="" ? "" : " *")}' | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S; }
yayfind(){ yay -Sl | awk '{print $2($4=="" ? "" : " *")}' | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S; }
yeet(){ pacman -Qqt | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns; }

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
source /usr/share/doc/pkgfile/command-not-found.bash

# Source the wal theme for terminals and TTYs
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

# Setup and source fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_CTRL_T_COMMAND='fd . --type f -H'
export FZF_ALT_C_COMMAND='fd . --type d -H'

# Source zoxide
eval "$(zoxide init bash)"

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

