alias history="history 0"
bindkey -e 
export CLICOLOR=1 
autoload -U colors && colors
export PS1="%{$fg[white]%}%n%{$reset_color%}@%{$fg[green]%}:%~%{$reset_color%}$ "

# tmux
tmux source-file ~/.tmux.conf

# auto-completion
autoload -Uz compinit && compinit -u

# docker
# eval $(docker-machine env default) 
