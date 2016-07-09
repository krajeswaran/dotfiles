# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
PAGER=less

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1="\n\[\e[0;32m\][\[\e[0;34m\]\u@\h\[\e[0;32m\]]:[\[\e[1;32m\]\w\[\e[0;32m\]] "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# custom stuff

#set -o vi
#bind -m vi-command ".":insert-last-argument
#bind -m vi-insert "\C-l.":clear-screen
#bind -m vi-insert "\C-a.":beginning-of-line
#bind -m vi-insert "\C-e.":end-of-line
#bind -m vi-insert "\C-w.":backward-kill-word

export PATH=/sbin:$HOME/bin:$HOME/.vim:$PATH

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session
#rvm use 1.9.3

alias vi="vim"
alias ll="ls -larth"
alias llm="ls -larth | less"
alias rm='rm -I'
alias revo="mosh thesanerevo"
alias router="mosh root@192.168.1.1"
alias box="mosh thesanebox"
alias diskusage="du -h -d 1"
alias sshfs='sshfs -C -o reconnect,workaround=all'
# newly born hostname, child or project?
alias namemaker="shuf -n 2 /usr/share/dict/words | tr -dc 'A-Za-z0-9'"
alias gitclean='git clean -fxdq'
alias gitpdiff='git diff HEAD --'
alias pwd="pwd -P"
alias mirror="mpv -vf screenshot tv://"
alias gitlog="git log --graph --pretty=format:'%C(yellow)%h%Creset -%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias smesg="tail -f /var/log/{messages,kernel,dmesg,syslog}"
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias jgrep='find . -name "*.java" -o -name "*.xml" -o -name "*.properties" -type f | xargs grep -nHi '

gitaddselective() {
    git add `git status --porcelain | grep ^" M" | cut -d " " -f3 | grep $1`
}

findandreplace() {
    find . -name "$1" -type f -print0 | xargs -0 perl -p -i -e "$2"
}

say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

# custom specific
if [ -f ~/.bashrc_common ]; then
    source ~/.bashrc_common
fi
