# MISC
alias history="history 0"
bindkey -e 
export CLICOLOR=1 
autoload -U colors && colors
export PS1="%{$fg[white]%}%n%{$reset_color%}@%{$fg[green]%}:%~%{$reset_color%}$ "
# eval $(docker-machine env default) 

# GOLANG
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# TMUX
tmux source-file ~/.tmux.conf

# auto-completion
autoload -Uz compinit && compinit -u

[ -f "/Users/ziyuanzhu/.ghcup/env" ] && source "/Users/ziyuanzhu/.ghcup/env" # ghcup-env
