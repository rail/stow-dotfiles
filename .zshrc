if test -x ~/bin/prokopton; then
  ~/bin/prokopton
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/rail/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
plugins=(git zoxide gh terraform starship)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

alias vi=nvim
alias vim=nvim
alias eza='eza '\''--icons'\'' '\''--git'\'''
alias la='eza -a'
alias ll='eza -l'
alias lla='eza -la'
alias ls='eza'
alias tree='eza --tree'


export PATH=$PATH:~/go/bin:~/go/src/github.com/cockroachdb/cockroach/bin
BREW_PREFIX=$(brew --prefix)

source "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
source "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"

PATH="$BREW_PREFIX/opt/make/libexec/gnubin:$PATH"
PATH=~/bin:$PATH

if [ -f ~/.cockroach.lic ]; then
  export COCKROACH_DEV_LICENSE="$(cat ~/.cockroach.lic)"
fi

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
  # osascript -e 'tell app "System Events" to display alert "CI Push Completed" message "CI push completed"'
}

function br_cleanup(){
  git branch --list  | cut -c 3- | gum choose --no-limit | xargs git branch -D
}

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
USE_GKE_GCLOUD_AUTH_PLUGIN=True


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $BREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
