PS1="[%n@%m %c]$ "
COPYFILE_DISABLE=true
PATH=~/bin:~/adt/sdk/tools:~/adt/sdk/platform-tools:/usr/local/sbin:/usr/local/bin:$PATH
#PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"

fpath=(~/.zfunctions $fpath)

autoload /usr/share/zsh/5.0.2/functions/*(:t)

export CLICOLOR=true
export GREP_OPTIONS="--color"

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export SVN_EDITOR=vim
export EDITOR=vim
export VISUAL=vim

autoload -U compinit promptinit
compinit
promptinit
prompt pure
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
alias 't=todo.sh'
alias 'vt=vim ~/Dropbox/todo/todo.txt'
alias 'glog=git log --all --graph --pretty=format:"%h %Cblue%cN %Cgreen%cr %Creset%s %n%Cred%d"'
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
            vim ~/Dropbox/Notes/$ARGSJOIN -c "cd ~/Dropbox/Notes"
        else
            vim ~/Dropbox/Notes/$ARGSJOIN.md -c "cd ~/Dropbox/Notes"
        fi
    fi
}
