# Configuration exports
FPATH=~/.zfunctions:$FPATH
export CLICOLOR=true
export GREP_OPTIONS="--color" # Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Setup homebrew prefixes
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$(brew --prefix)/share/zsh/functions:$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Load and init zsh extensions
autoload -Uz compinit promptinit
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
compinit
promptinit

# Set ZSH options and keys
prompt pure

setopt completealiases
zstyle ':completion:*' menu select
setopt NOCLOBBER
setopt RM_STAR_WAIT

bindkey -v
bindkey -M vicmd '?' history-incremental-search-backward
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Make ls colored
if [[ -x `which dircolors` ]]; then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
fi

# Convenience aliases
alias 'dus=du -ms * | sort -n'
alias 'glog=git log --all --graph --pretty=format:"%Cred%d%Creset %h %Cblue%aN %Cgreen%ai %Creset%s"'
alias 'glogg=git log --graph --pretty=format:"%Cred%d%Creset %h %Cblue%aN %Cgreen%ai %Creset%s"'
alias 'vim=nvim'
alias "ic=cd '$IC'"
alias 'vpn=sudo openconnect --user=cccfjd --csd-user=nobody --csd-wrapper=/usr/local/Cellar/openconnect/8.10/libexec/openconnect/csd-post.sh amvpn1.corp.global/tiscontractor'

# Utility functions
function delete_and_update_tag() {
        TAG=$1
        git push origin :${TAG}
        git tag -d ${TAG}
        git tag ${TAG}
        git push origin ${TAG}
}

function aws_poc() {
        unset AWS_SESSION_TOKEN
        unset AWS_SECURITY_TOKEN
        AWS_ACCESS_KEY_ID="$ZSH_CREDENTIALS_AWS_ACCESS_KEY_ID_TIS_POC_MFA"
        AWS_SECRET_ACCESS_KEY="$ZSH_CREDENTIALS_AWS_SECRET_ACCESS_KEY_TIS_POC_MFA"
        response=$(aws sts get-session-token --serial-number 'arn:aws:iam::216699939416:mfa/dmenssen_mfa' --token-code $1)
        export AWS_ACCESS_KEY_ID=$(echo "$response" | jq -r .Credentials.AccessKeyId)
        export AWS_SECRET_ACCESS_KEY=$(echo "$response" | jq -r .Credentials.SecretAccessKey)
        export AWS_SESSION_TOKEN=$(echo "$response" | jq -r .Credentials.SessionToken)
        export AWS_DEFAULT_REGION=us-east-1
        export TF_VAR_region=us-east-1
}

function dclean {
  echo "Removing dead containers..."
  docker container rm $(docker container ls -a -q -f status=dead) 2>/dev/null || echo "...No dead containers to remove."

  echo "Removing stopped containers..."
  docker rm $(docker ps --all --quiet --filter status=exited) 2>/dev/null|| echo "...No stopped containers to remove."

  echo "Removing untagged images..."
  docker rmi $(docker images --quiet --filter dangling=true) 2>/dev/null || echo "...No dead images to remove."
}
