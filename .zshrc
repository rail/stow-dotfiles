OS=$(uname)

if test -x ~/bin/prokopton; then
  ~/bin/prokopton
fi

export ZSH="$HOME/.oh-my-zsh"
plugins=(zoxide gh terraform starship)
if [[ $OS == "Darwin" ]]; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
source $ZSH/oh-my-zsh.sh


alias vi=nvim
alias vim=nvim
alias eza='eza --icons --git'
alias la='eza -a'
alias ll='eza -l'
alias lla='eza -la'
alias ls='eza'
alias tree='eza --tree'

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
