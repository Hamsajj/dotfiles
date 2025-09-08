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
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
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

# Set GOPRIVATE for Volvo
GOPRIVATE="https://github.com/epidemicsound/*"


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
export TESTCONTAINERS_HOST_OVERRIDE=$(rdctl shell ip a show rd0 | awk '/inet / {sub("/.*",""); print $2}')

# pnpm
export PNPM_HOME="/Users/hamid.sajjadi/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
