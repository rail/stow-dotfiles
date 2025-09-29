HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

DISABLE_MAGIC_FUNCTIONS=true
ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
plugins=(zoxide gh terraform starship fzf)

OS=$(uname)
if [[ $OS == "Darwin" ]]; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
source $ZSH/oh-my-zsh.sh


alias vi=nvim
alias vim=nvim
alias eza='eza --icons --git'
alias la='eza -a --icons --git'
alias ll='eza -l --icons --git'
alias lla='eza -la --icons --git'
alias ls='eza --icons --git'
alias tree='eza --tree --icons --git'

if [[ $OS == "Darwin" ]]; then
  BREW_PREFIX=$(brew --prefix)
  PATH="$BREW_PREFIX/opt/make/libexec/gnubin:$PATH"
  source "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
  source "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
  source "$BREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

PATH=~/bin:$PATH
export PATH=$PATH:~/go/bin:~/go/src/github.com/cockroachdb/cockroach/bin
export EDITOR='nvim'
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True


if [ -f ~/.cockroach.lic ]; then
  export COCKROACH_DEV_LICENSE="$(cat ~/.cockroach.lic)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function cla() {
  gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -f state='success' \
    -f description='CLA status forced by CLI' \
    -f context='license/cla' \
    /repos/cockroachdb/cockroach/statuses/$1
}

function ci() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  local user=$(whoami)
  git push -f git@github.com:cockroachdb/cockroach.git HEAD:refs/ci/$user/$branch
  echo "Visit the following URL in a minute or two: https://teamcity.cockroachdb.com/buildConfiguration/Cockroach_UnitTests?branch=${user}%2F${branch}"
}

function br_cleanup(){
  git branch --list  | cut -c 3- | gum choose --no-limit | xargs git branch -D
}

export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_VERTEX_PROJECT_ID=vertex-model-runners
export PATH="$HOME/.local/bin:$PATH"
