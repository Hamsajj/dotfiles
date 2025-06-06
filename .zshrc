# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="${HOME}/.colima/default/docker.sock"
#export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
#export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
#export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"

export PATH=${HOME}/go/bin/:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export GOPATH="$HOME/go"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
 )
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias ls="ls -lGH"
alias ll="ls -lh"
alias lt="du -sh * | sort -h"
alias c="clear"

# remove machine name for agnoster theme
#export DEFAULT_USER="shs"
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# GIT aliases
alias ghr="git fetch && git rebase origin/main"
alias gam="git add . && git commit --amend --no-edit"

export GOPRIVATE="github.com/eMarketeerSE"
alias python='python3'
export GPG_TTY=$(tty)
alias dps='docker ps --format "table {{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Names}}\\t{{.Ports}}"'



alias cdv='cd ~/repos/volvo'
alias tf='tofu'
alias ghsha='git rev-parse HEAD | striplines | pbcopy'
eval "$(direnv hook zsh)"
GOPRIVATE="github.com/volvo-cars/*"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/hive/bin:$PATH"
## Kubectl
alias kb='kubectl'
alias k='kubectl'
alias kbx='kubectl config use-context'
source  <(kb completion zsh | sed s/kubectl/kb/g)

fpath=(~/.zfunc $fpath);


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/HSAJJADI/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export NVM_DIR="$HOME/.nvm"

# Load the last used Node.js version without fully initializing NVM
# Resolve the full Node.js version
if [ -s "$NVM_DIR/alias/default" ]; then
  NODE_VERSION=$(cat "$NVM_DIR/alias/default")
  FULL_NODE_VERSION=$(command ls -d "$NVM_DIR/versions/node/v${NODE_VERSION}."* 2>/dev/null | sort -V | tail -n 1)

  if [ -n "$FULL_NODE_VERSION" ]; then
    export PATH="$FULL_NODE_VERSION/bin:$PATH"
  fi
fi

start_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # Load nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # Load completion
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/HSAJJADI/.gcp/path.zsh.inc' ]; then . '/Users/HSAJJADI/.gcp/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/HSAJJADI/.gcp/completion.zsh.inc' ]; then . '/Users/HSAJJADI/.gcp/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/HSAJJADI/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias ncfg="cd ~/.config/nvim"
