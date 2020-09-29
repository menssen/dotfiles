source ~/.zshcreds

PS1="[%n@%m %c]$ "
COPYFILE_DISABLE=true

PATH=~/bin:/usr/local/sbin:/usr/local/bin:$PATH
# PATH=/Applications/VMware\ Fusion.app/Contents/Library:~/bin:~/adt/sdk/tools:~/adt/sdk/platform-tools:/usr/local/sbin:/usr/local/bin:~/Library/Python/2.7/bin:$PATH
# PATH="/usr/local/opt/terraform@0.12/bin:$PATH"

export P4PORT=1666
export P4HOST=TYR-RV-ENG2P.AD.CORP.GLOBAL
export P4USER=cccfjd
export P4PASSWD="$ZSH_CREDENTIALS_P4PASSWD"

# /usr/local/opt/terraform@0.11/bin:

fpath=(~/.zfunctions $fpath)


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$(brew --prefix)/share/zsh/functions:$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit promptinit
else
  autoload /usr/share/zsh/5.7.1/functions/*(:t)
  autoload -U compinit promptinit
fi

compinit
promptinit
prompt pure

export CLICOLOR=true
export GREP_OPTIONS="--color"

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export SVN_EDITOR=vim
export EDITOR=vim
export VISUAL=vim

bindkey -v

setopt completealiases
zstyle ':completion:*' menu select

bindkey -M vicmd '?' history-incremental-search-backward
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

setopt NOCLOBBER
setopt RM_STAR_WAIT

if [[ "$TERM" != "dumb" ]]; then
    if [[ -x `which dircolors` ]]; then
	eval `dircolors -b`
	alias 'ls=ls --color=auto'
    fi
fi

alias 'dus=du -ms * | sort -n'
# alias 'glog=git log --all --graph --pretty=format:"%h %Cblue%cN %Cgreen%ci %Creset%s %n%Cred%d"'
# alias 'glogg=git log --graph --pretty=format:"%h %Cblue%cN %Cgreen%ci %Creset%s %n%Cred%d"'

alias 'glog=git log --all --graph --pretty=format:"%Cred%d%Creset %h %Cblue%aN %Cgreen%ai %Creset%s"'
alias 'glogg=git log --graph --pretty=format:"%Cred%d%Creset %h %Cblue%aN %Cgreen%ai %Creset%s"'
alias 'vim=nvim'

install_all_packages() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install git zsh node zsh-syntax-highlighting jq vim the_silver_searcher
}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# export CATALINA_OPTS="-Xmx2048m -XX:MaxPermSize=1024m"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.7.jdk/Contents/Home
export HOMEBREW_GITHUB_API_TOKEN="$ZSH_CREDENTIALS_HOMEBREW_GITHUB_API_TOKEN"
# export CATALINA_PID="/usr/local/Cellar/tomcat/8.0.15/libexec/catalina_pid.txt"

# export MAVEN_OPTS=""

alias 'vpn=sudo openconnect --user=cccfjd --csd-user=nobody --csd-wrapper=/usr/local/Cellar/openconnect/8.10/libexec/openconnect/csd-post.sh amvpn1.corp.global/tiscontractor'

function delete_and_update_tag() {
        TAG=$1
        git push origin :${TAG}
        git tag -d ${TAG}
        git tag ${TAG}
        git push origin ${TAG}
}

export AWS_ACCESS_KEY_ID="$ZSH_CREDENTIALS_AWS_ACCESS_KEY_ID_TIS_DEV"
export AWS_SECRET_ACCESS_KEY="$ZSH_CREDENTIALS_AWS_SECRET_ACCESS_KEY_TIS_DEV"

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



source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
