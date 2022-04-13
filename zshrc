# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Antibody bundles
source ~/.zsh_plugins.sh

# Custom functions
fpath+=~/.zfunc

##########
# Prompt #
##########
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# export GEOMETRY_STATUS_SYMBOL_ERROR="▲" 
# export GEOMETRY_STATUS_COLOR_ERROR="green"
# export GEOMETRY_EXITCODE_COLOR="green"
# export GEOMETRY_HOSTNAME_HIDE_ON="ironclad"
# export GEOMETRY_PATH_TRUNCATE=1
# export GEOMETRY_PATH_COLOR=253
# export GEOMETRY_GIT_COLOR_BRANCH=245

# export GEOMETRY_PROMPT=(geometry_exitcode geometry_hostname geometry_path geometry_status)
# export GEOMETRY_RPROMPT=(geometry_git_conflicts geometry_git_rebase geometry_git_remote geometry_git_branch)

PS1="%F{124}%(?..%? )%f"

PS1+='%1~ %% '

# Required for deoplete completions
zmodload zsh/zpty

# initialize pyenv's virtualenv plugin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;



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

export SPACESHIP_CHAR_SYMBOL_ROOT='#'

export JIRA_API_TOKEN=ZfoLj217nDKm4GHgj8fY12EE

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kellen/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kellen/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kellen/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kellen/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
