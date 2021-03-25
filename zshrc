GEOMETRY_PROMPT=(geometry_status geometry_jobs geometry_path)
GEOMETRY_RPROMPT=(geometry_git)
GEOMETRY_EXITCODE_COLOR="red"

# Antibody bundles
source ~/.zsh_plugins.sh

# Custom functions
fpath+=~/.zfunc
fpath+=~/.zsh/pure

##########
# Prompt #
##########
autoload -U promptinit; promptinit
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Required for deoplete completions
zmodload zsh/zpty

# Sourcing
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source $HOME/.cargo/env

# Completions
# ignore these files in tab completion
FIGNORE=".o:~"                  
# completions push cursor to end
setopt ALWAYS_TO_END            
setopt CORRECT
# Command completion for network commands
compctl -v setenv               
# Compinstall
zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-prompt '%SAt %p: Hit <tab> for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending   
autoload -Uz compinit
# Only compile completions once per day
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2767420
setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(#qN.m1); do
    compinit
    if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
        zcompile "$dump"
    fi
done
unsetopt EXTENDEDGLOB
compinit -C



# Navigation
# cd and pushd are separate commands
setopt NO_AUTO_PUSHD            
# cd with just the directory name
setopt AUTO_CD                  
# do not insert duplicates into pushd
setopt PUSHD_IGNORE_DUPS        

# History
# store time in history
setopt EXTENDED_HISTORY         
# unique events are more usefull to me
setopt HIST_EXPIRE_DUPS_FIRST   
# Make those history commands nice
setopt HIST_VERIFY              
# immediatly insert history into history file
setopt INC_APPEND_HISTORY       
# share history among sessions
setopt SHARE_HISTORY            
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
# spots for duplicates/uniques
HISTSIZE=1600000
# unique events guaranteed
SAVEHIST=1500000
HISTFILE=~/.zshhistory

# Sanity
setopt NOBEEP
setopt NO_LIST_BEEP

# Emacs mode for zsh
bindkey -e
# Search the history
bindkey "^S" history-incremental-search-backward    
bindkey "^E" end-of-line
bindkey "^A" beginning-of-line

# Bind ctrl-< and ctrl-> to navigate by word
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
autoload -U select-word-style
# Bash-style word separators stop at file path separators
select-word-style bash  

# Get around argument list limits
autoload zargs;

# Aliases
alias ls='ls -F'

# Tmux
if [[ -z $TMUX ]]; then
    sessions=$( tmux ls 2> /dev/null | awk '! /attached/ { sub(":", "", $1); print $1; }' | xargs echo )
    if [[ ! -z $sessions ]]; then
        echo "===> Available tmux sessions: $sessions"
    fi
    unset sessions
fi

# No ads in my terminal, please
export ADBLOCK=1
export DISABLE_OPENCOLLECTIVE=1

# N node version manager
export N_PREFIX=$HOME/.local/share
export PATH=$N_PREFIX/bin:$PATH

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

export SPACESHIP_CHAR_SYMBOL_ROOT='#'

# Disable lando's verbosity
alias lando="NODE_NO_WARNINGS=1 lando"

eval "$(starship init zsh)"

