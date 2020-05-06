PS1="[%n@%m %c]$ "
COPYFILE_DISABLE=true

PATH=/Applications/VMware\ Fusion.app/Contents/Library:~/bin:~/adt/sdk/tools:~/adt/sdk/platform-tools:/usr/local/sbin:/usr/local/bin:~/Library/Python/2.7/bin:$PATH

# /usr/local/opt/terraform@0.11/bin:

fpath=(~/.zfunctions $fpath)

autoload /usr/share/zsh/5.7.1/functions/*(:t)
autoload -U compinit promptinit

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

n() {
    if [[ $# < 1 ]]; then
        vim ~/Dropbox/Notes/scratch.md -c "cd ~/Dropbox/Notes"
    else
        SAVE_IFS="$IFS"
        IFS=" "
        ARGS=("$@")
        ARGSJOIN="${ARGS[*]}"
        IFS="$SAVE_IFS"

        if [[ "$ARGSJOIN" == *.* ]]; then
            vim "~/Dropbox/Notes/$ARGSJOIN" -c "cd ~/Dropbox/Notes"
        else
            vim "~/Dropbox/Notes/$ARGSJOIN.md" -c "cd ~/Dropbox/Notes"
        fi
    fi
}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# export CATALINA_OPTS="-Xmx2048m -XX:MaxPermSize=1024m"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home
export HOMEBREW_GITHUB_API_TOKEN=2fcfc6b2cd8067ddf96c79d60826787e7e19ad1b
# export CATALINA_PID="/usr/local/Cellar/tomcat/8.0.15/libexec/catalina_pid.txt"

# export MAVEN_OPTS=""

export NVM_DIR="/Users/34617/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/34617/.sdkman"
# [[ -s "/Users/34617/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/34617/.sdkman/bin/sdkman-init.sh"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# eval $(minishift oc-env)
#
#

# TIS selenium tests
export SELENIUM_ENV=DevEnv
export SELENIUM_SITE_URL=http://localhost:8080

alias 'vpn=sudo openconnect --user=cccfjd --csd-user=nobody --csd-wrapper=/usr/local/Cellar/openconnect/8.05/libexec/openconnect/csd-post.sh amvpn1.corp.global/tiscontractor'

function delete_and_update_tag() {
        TAG=$1
        git push origin :${TAG}
        git tag -d ${TAG}
        git tag ${TAG}
        git push origin ${TAG}
}

function aws_dev() {
        echo $1 >&2
        export TIS_ENV='dev'
        export TIS_REGION='us-east-1'
        AWS_ACCESS_KEY_ID='redacted'
        AWS_SECRET_ACCESS_KEY='redacted'
        echo aws sts get-session-token --serial-number 'redacted' --token-code $1
        response=$(aws sts get-session-token --serial-number 'redacted' --token-code $1)
        echo $(echo "$response" | jq -r .Credentials.AccessKeyId)
        tf=$(echo "$response" | jq -r .Credentials.AccessKeyId)
        echo $tf
        export TF_VAR_access_key=$(echo "$response" | jq -r .Credentials.AccessKeyId)
        export TF_VAR_secret_key=$(echo "$response" | jq -r .Credentials.SecretAccessKey)
        export TF_VAR_token=$(echo "$response" | jq -r .Credentials.SessionToken)
        export AWS_ACCESS_KEY_ID=$(echo "$response" | jq -r .Credentials.AccessKeyId)
        export AWS_SECRET_ACCESS_KEY=$(echo "$response" | jq -r .Credentials.SecretAccessKey)
}


# function aws_poc() {
#         echo $1 >&2
#         export TIS_ENV='tools'
#         export TIS_REGION='us-east-1'
#         AWS_ACCESS_KEY_ID='redacted'
#         AWS_SECRET_ACCESS_KEY='redacted'
#         echo aws sts get-session-token --serial-number 'redacted' --token-code $1
#         response=$(aws sts get-session-token --serial-number 'redacted' --token-code $1)
#         echo $(echo "$response" | jq -r .Credentials.AccessKeyId)
#         tf=$(echo "$response" | jq -r .Credentials.AccessKeyId)
#         echo $tf
#         export TF_VAR_access_key=$(echo "$response" | jq -r .Credentials.AccessKeyId)
#         export TF_VAR_secret_key=$(echo "$response" | jq -r .Credentials.SecretAccessKey)
#         export TF_VAR_token=$(echo "$response" | jq -r .Credentials.SessionToken)
#         # export AWS_ACCESS_KEY_ID=$(echo "$response" | jq -r .Credentials.AccessKeyId)
#         # export AWS_SECRET_ACCESS_KEY=$(echo "$response" | jq -r .Credentials.SecretAccessKey)
# }

function aws_poc() {
        unset AWS_SESSION_TOKEN
        unset AWS_SECURITY_TOKEN
        AWS_ACCESS_KEY_ID='redacted'
        AWS_SECRET_ACCESS_KEY='redacted'
        response=$(aws sts get-session-token --serial-number 'redacted' --token-code $1)
        export AWS_ACCESS_KEY_ID=$(echo "$response" | jq -r .Credentials.AccessKeyId)
        export AWS_SECRET_ACCESS_KEY=$(echo "$response" | jq -r .Credentials.SecretAccessKey)
        export AWS_SESSION_TOKEN=$(echo "$response" | jq -r .Credentials.SessionToken)
        export AWS_DEFAULT_REGION=us-east-1
}
