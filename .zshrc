fpath=(/Users/hamid.sajjadi/.local/share/zsh/site-functions $fpath)
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install zinit if not present
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -Uz compinit
compinit -C

# Environment variables
export GOPATH="${HOME}/go"
export PATH=${GOPATH}/bin/:$PATH
export GPG_TTY=$(tty)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/hive/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim


# --- Vi mode ---
bindkey -v

# Faster mode switching
KEYTIMEOUT=1

# --- Edit command line in $EDITOR ---
autoload -Uz edit-command-line
zle -N edit-command-line

# Bind in both modes
# bindkey -M vicmd 'v' edit-command-line
bindkey -M viins '^X^E' edit-command-line

# Theme (agnoster equivalent) - load first for prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k
# Note: You'll need to configure p10k or use agnoster alternative below

# Alternative: Use original agnoster theme
# zinit snippet OMZL::git.zsh
# zinit snippet OMZL::theme-and-appearance.zsh
# zinit snippet OMZT::agnoster

# Essential plugins - load in order of importance
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Git plugin functionality
zinit snippet OMZP::git


zinit light jeffreytse/zsh-vi-mode

# Completion settings
zstyle ':completion:*' rehash true

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Menu selection for completions
zstyle ':completion:*' menu select

# Group completions by category
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'

# Cache completions for better performance
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fuzzy
# Install fzf
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf
# zinit light Aloxaf/fzf-tab

# Aliases
alias zshrc="nvim ~/.zshrc && source ~/.zshrc"
alias ls="ls -lGH"
alias ll="ls -lh"
alias lt="du -sh * | sort -h"
alias c="clear"
alias ghr="git fetch && git rebase origin/main"
alias gam="git add . && git commit --amend --no-edit"
alias python='python3'
alias dps='docker ps --format "table {{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Names}}\\t{{.Ports}}"'
alias cdes='cd ~/repos/epidemic'
alias tf='tofu'
alias ghsha='git rev-parse HEAD | striplines | pbcopy'
alias kb='kubectl'
alias k='kubectl'
alias kbx='kubectl config use-context'
alias ncfg="cd ~/.config/nvim"

# Tool initializations
eval "$(direnv hook zsh)"

# Kubectl completion
source <(kb completion zsh | sed s/kubectl/kb/g)

# Function path
fpath=(~/.zfunc $fpath)

# NVM lazy loading (performance optimized)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/alias/default" ]; then
  NODE_VERSION=$(cat "$NVM_DIR/alias/default")
  FULL_NODE_VERSION=$(command ls -d "$NVM_DIR/versions/node/${NODE_VERSION}"* 2>/dev/null | sort -V | tail -n 1)
  if [ -n "$FULL_NODE_VERSION" ]; then
    export PATH="$FULL_NODE_VERSION/bin:$PATH"
  fi
fi

start_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}


# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

GOPRIVATE="https://github.com/epidemicsound"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="${HOME}/flutter/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hamid.sajjadi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/hamid.sajjadi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hamid.sajjadi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/hamid.sajjadi/google-cloud-sdk/completion.zsh.inc'; fi 
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export PATH="${HOME}/.local/bin:$PATH"
# To change lazygit config folder
export XDG_CONFIG_HOME="$HOME/.config"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/hamid.sajjadi/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

### TESTCONTAINERS WITH RANCHER DESKTOP
export DOCKER_HOST=unix://$HOME/.rd/docker.sock
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export TESTCONTAINERS_HOST_OVERRIDE=localhost

# pnpm
export PNPM_HOME="/Users/hamid.sajjadi/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
 export PATH="$PATH":"$HOME/.pub-cache/bin"
# Add GITHUB_TOKEN used for authenticating npm
# if [[ -e ~/.npmrc ]]; then
#   export GITHUB_TOKEN=$(cat ~/.npmrc | grep //npm.pkg.github.com/:_authToken= | sed 's/^.*=//')
# fi

## Helpers function to cd to project directory
cde() {
  # Default to the epidemic path
  local base_path="$HOME/repos/epidemic"
  local target_dir="$1"

  # Check for the 'personal' flag
  if [[ "$1" == "-p" || "$1" == "--personal" ]]; then
    base_path="$HOME/repos/personal"
    # The actual directory is the second argument
    target_dir="$2"
  fi

  # If a target directory is specified, append it to the base path
  if [[ -n "$target_dir" ]]; then
    cd "${base_path}/${target_dir}"
  else
    # If no directory is specified, go to the base path
    # (e.g., `cde` goes to ~/repos/epidemic, `cde -p` goes to ~/repos/personal)
    cd "${base_path}"
  fi
}

# Added by Antigravity
export PATH="${HOME}/.antigravity/antigravity/bin:${PATH}"
export PATH="${HOME}/.volta/bin:${PATH}"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
eval "$(pyenv init --path)"


## GO PROXY ENV VARS
export GOPROXY="https://europe-west1-go.pkg.dev/es-shared-mgmt-02dd/eu-we1-golang,https://proxy.golang.org,direct"
export GONOSUMDB="github.com/epidemicsound/*"
export GOPRIVATE="github.com/epidemicsound/*"
export GONOPROXY="github.com/GoogleCloudPlatform/artifact-registry-go-tools"

alias pi="ssh berry@berry.local"
