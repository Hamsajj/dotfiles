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
export PATH=${HOME}/go/bin/:$PATH
export GOPATH="$HOME/go"
export GOPRIVATE="github.com/eMarketeerSE"
export GPG_TTY=$(tty)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/hive/bin:$PATH"
export PATH="/Users/HSAJJADI/.rd/bin:$PATH"

# Theme (agnoster equivalent) - load first for prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k
# Note: You'll need to configure p10k or use agnoster alternative below

# Alternative: Use original agnoster theme
zinit snippet OMZL::git.zsh
# zinit snippet OMZL::theme-and-appearance.zsh
# zinit snippet OMZT::agnoster

# Essential plugins - load in order of importance
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Git plugin functionality
# zinit snippet OMZP::git

# Completion settings
zstyle ':completion:*' rehash true

# Custom prompt function for agnoster-like behavior
#prompt_context() {
#  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#  fi
#}

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
alias cdv='cd ~/repos/volvo'
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
  FULL_NODE_VERSION=$(command ls -d "$NVM_DIR/versions/node/v${NODE_VERSION}."* 2>/dev/null | sort -V | tail -n 1)
  if [ -n "$FULL_NODE_VERSION" ]; then
    export PATH="$FULL_NODE_VERSION/bin:$PATH"
  fi
fi

start_nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Google Cloud SDK
if [ -f '/Users/HSAJJADI/.gcp/path.zsh.inc' ]; then . '/Users/HSAJJADI/.gcp/path.zsh.inc'; fi
if [ -f '/Users/HSAJJADI/.gcp/completion.zsh.inc' ]; then . '/Users/HSAJJADI/.gcp/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/HSAJJADI/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Set GOPRIVATE for Volvo
GOPRIVATE="github.com/volvo-cars/*"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
