PS1="[%n@%m %c]$ "
COPYFILE_DISABLE=true

PATH=/Applications/VMware\ Fusion.app/Contents/Library:~/bin:~/adt/sdk/tools:~/adt/sdk/platform-tools:/usr/local/sbin:/usr/local/bin:$PATH

fpath=(~/.zfunctions $fpath)

autoload /usr/share/zsh/5.0.5/functions/*(:t)
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

alias 'glog=git log --all --graph --pretty=format:"%Cred%d%Creset %h %Cblue%cN %Cgreen%ci %Creset%s"'
alias 'glogg=git log --graph --pretty=format:"%Cred%d %h %Cblue%cN %Cgreen%ci %Creset%s"'

install_all_packages() {
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install git zsh node zsh-syntax-highlighting
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

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/dmenssen/.gvm/bin/gvm-init.sh" ]] && source "/Users/dmenssen/.gvm/bin/gvm-init.sh"


source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
export HOMEBREW_GITHUB_API_TOKEN=2fcfc6b2cd8067ddf96c79d60826787e7e19ad1b
export CATALINA_PID="/usr/local/Cellar/tomcat/8.0.15/libexec/catalina_pid.txt"

export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=1024m"
