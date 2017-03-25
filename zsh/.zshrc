#-----------------------------
# Source some stuff
#-----------------------------

if [[ -f "$HOME/.zfunctions/git-status.zsh" ]]; then
    . "$HOME/.zfunctions/git-status.zsh"
fi

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=( "$HOME/.zfunctions" $fpath )


#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.zhistory
HISTSIZE=50000
SAVEHIST=50000

#------------------------------
# Variables
#------------------------------
export EDITOR="vim"

#-----------------------------
# Dircolors
#-----------------------------
# LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
# export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
bindkey -v

# VI MODE KEYBINDINGS (ins mode)                                      
bindkey -M viins '^a'    beginning-of-line                            
bindkey -M viins '^e'    end-of-line                                  
bindkey -M viins '^k'    kill-line                                    
bindkey -M viins '^r'    history-incremental-pattern-search-backward  
bindkey -M viins '^s'    history-incremental-pattern-search-forward   
bindkey -M viins '^p'    up-line-or-history                           
bindkey -M viins '^n'    down-line-or-history                         
bindkey -M viins '^y'    yank                                         
bindkey -M viins '^w'    backward-kill-word                           
bindkey -M viins '^u'    backward-kill-line                           
bindkey -M viins '^h'    backward-delete-char                         
bindkey -M viins '^?'    backward-delete-char                         
bindkey -M viins '^_'    undo                                         
bindkey -M viins '^x^r'  redisplay                                    
bindkey -M viins '\eOH'  beginning-of-line # Home                     
bindkey -M viins '\eOF'  end-of-line       # End                      
bindkey -M viins '\e[2~' overwrite-mode    # Insert                   
bindkey -M viins '\ef'   forward-word      # Alt-f                    
bindkey -M viins '\eb'   backward-word     # Alt-b                    
bindkey -M viins '\ed'   kill-word         # Alt-d                    
                                                                      
                                                                      
# VI MODE KEYBINDINGS (cmd mode)                                      
bindkey -M vicmd '^a'    beginning-of-line                            
bindkey -M vicmd '^e'    end-of-line                                  
bindkey -M vicmd '^k'    kill-line                                    
bindkey -M vicmd '^r'    history-incremental-pattern-search-backward  
bindkey -M vicmd '^s'    history-incremental-pattern-search-forward   
bindkey -M vicmd '^p'    up-line-or-history                           
bindkey -M vicmd '^n'    down-line-or-history                         
bindkey -M vicmd '^y'    yank                                         
bindkey -M vicmd '^w'    backward-kill-word                           
bindkey -M vicmd '^u'    backward-kill-line                           
bindkey -M vicmd '/'     vi-history-search-forward                    
bindkey -M vicmd '?'     vi-history-search-backward                   
bindkey -M vicmd '^_'    undo                                         
bindkey -M vicmd '\ef'   forward-word                      # Alt-f    
bindkey -M vicmd '\eb'   backward-word                     # Alt-b    
bindkey -M vicmd '\ed'   kill-word                         # Alt-d    
bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp   
bindkey -M vicmd '\e[6~' history-beginning-search-forward  # PageDown 
bindkey '\e.' insert-last-word

export KEYTIMEOUT=1



#------------------------------
# Alias stuff
#------------------------------
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gl='git pull'
alias gup='git pull --rebase'
alias gp='git push'
alias gd='git diff'
alias gdt='git difftool'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch --remote'
alias gcount='git shortlog -sn'
alias gcl='git config --list'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate --color'
alias glog='git log --oneline --decorate --color --graph'
alias gss='git status -s'
alias ga='git add'
alias gap='git add --patch'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

# Sign and verify commits with GPG
alias gcs='git commit -S'
alias gsps='git show --pretty=short --show-signature'

# Sign and verify tags with GPG
alias gts='git tag -s'
alias gvt='git verify-tag'

#remove the gf alias
#alias gf='git ls-files | grep'

alias gpoat='git push origin --all && git push origin --tags'
alias gmt='git mergetool --no-prompt'

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

alias gsr='git svn rebase'
alias gsd='git svn dcommit'
#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpur='git pull --rebase origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
alias glp="_git_log_prettily"

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}
# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
# list temporarily ignored files
alias gignored='git ls-files -v | grep "^[[:lower:]]"'


#------------------------------
# options
#------------------------------
# ===== Basics
setopt no_beep # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells (especially for Muness)

# ===== Changing Directories
setopt auto_cd # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevarS # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack

# ===== Expansion and Globbing
setopt extended_glob # treat #, ~, and ^ as part of patterns for filename generation

# ===== History
setopt append_history # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history # save timestamp of command and duration
setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt hist_verify # don't execute, just expand history
setopt share_history # imports new commands and appends typed commands to history

# ===== Completion 
setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word    
setopt auto_menu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase

unsetopt menu_complete # do not autoselect the first completion entry

# ===== Correction
setopt correct # spelling correction for commands
setopt correctall # spelling correction for arguments

# ===== Prompt
setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

# ===== Scripts and Functions
setopt multios # perform implicit tees or cats when multiple redirections are attempted
#------------------------------
# Comp stuff
#------------------------------
autoload -Uz compinit 
compinit -u -i
zmodload -i zsh/complist

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git #svn cvs 

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions
 
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
 
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

zstyle :compinstall filename '${HOME}/.zshrc'

setopt COMPLETE_ALIASES

#------------------------------
# History search
#------------------------------

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors
autoload -Uz promptinit
promptinit

prompt purity

#------------------------------
# custom stuf
#------------------------------
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc_common" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc_common"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
