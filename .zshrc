source ~/.zshcreds

COPYFILE_DISABLE=true
PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# Homebrew
PATH=/usr/local/sbin:/usr/local/bin:$PATH

# Postgres
PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Python
PATH=/Users/dan/Library/Python/3.9/bin:$PATH
PATH=/usr/local/Cellar/python@3.9/3.9.1_1/bin:$PATH


# Ruby
# PATH=/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/ruby/bin:$PATH
# PATH=/usr/local/lib/ruby/gems/3.1.0/bin:/usr/local/opt/ruby/bin:$PATH
export PATH="/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/ruby@2.7/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
# eval "$(rbenv init -)"

# # Terraform
PATH=/opt/bin:~/bin:/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:$PATH
PATH=/Users/dan/Library/Android/sdk/platform-tools:/Users/dan/Library/Android/sdk/tools:$PATH
# PATH=/Applications/VMware\ Fusion.app/Contents/Library:~/bin:~/adt/sdk/tools:~/adt/sdk/platform-tools:/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:~/Library/Python/2.7/bin:$PATH
# PATH="/usr/local/opt/terraform@0.12/bin:$PATH"

# homebrew ruby
PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH"

# Perforce
export P4CLIENT=p4git
export P4PORT=TYR-RV-ENG2P.AD.CORP.GLOBAL:1666
export P4HOST=TYR-RV-ENG2P.AD.CORP.GLOBAL
export P4USER=u208115
export P4PASSWD="$ZSH_CREDENTIALS_P4PASSWD"

# iCloud Drive Shortcut
export IC='/Users/dan/Library/Mobile Documents/com~apple~CloudDocs'

# Always use neovim for editor
export SVN_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

# Java
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"

# export CATALINA_OPTS="-Xmx2048m -XX:MaxPermSize=1024m"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.7.jdk/Contents/Home
# export CATALINA_PID="/usr/local/Cellar/tomcat/8.0.15/libexec/catalina_pid.txt"

# AWS
export AWS_ACCESS_KEY_ID="$ZSH_CREDENTIALS_AWS_ACCESS_KEY_ID_TIS_DEV"
export AWS_SECRET_ACCESS_KEY="$ZSH_CREDENTIALS_AWS_SECRET_ACCESS_KEY_TIS_DEV"

# Android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PATH:$ANDROID_HOME/platform-tools"
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
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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

function ff() {
  find . -name "*$1*"
}

# alias 'vpn=sudo openconnect --user=cccfjd --csd-user=nobody --csd-wrapper=/usr/local/Cellar/openconnect/8.10/libexec/openconnect/csd-post.sh amvpn1.corp.global/tiscontractor'

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

function dstop {
        echo "Stopping all docker containers..."
        docker stop $(docker ps --all --quiet)

        echo "Stopping mutagen project..."
        mutagen project terminate
}

# Created by `pipx` on 2021-03-29 16:55:21
export PATH="$PATH:/Users/dan/.local/bin"
