# Tavish's .bashrc or .profile file

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9000
HISTFILESIZE=90000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

echo $HOME | grep /Users > /dev/null
if [ "$?"="0" ];
then
  tavish_on_a_mac=yes
else
  tavish_on_a_mac=no
fi

do_if_on_mac() {
  if [ "$tavish_on_a_mac"="yes" ];
  then
    $@
  fi
}

if [ "$tavish_on_a_mac"="yes" ];
then
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

do_if_on_mac export HOMEBREW_NO_EMOJI=1

# Host-specific aliases.
if [ -f ~/.host_aliases ]; then
    . ~/.host_aliases
fi
# Host-specific things I don't want to put in my public bashrc.
if [ -f ~/.bash_private ]; then
    . ~/.bash_private
fi

# Enable tab-completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias ack='ack-grep'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Jeff Wallace's custom prompt format string, green user@hostname, blue current path, red current branch in parnthesis
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[\033[31m\]\$(parse_git_branch)\[\033[00m\]\$ " 

alias gs="git status"
alias gl="git log"
alias gll="git log --pretty=oneline"
alias gd="git diff"
alias gc="git commit"
alias amend="git commit -a --amend"

export PAGER='less'

# Keep a list of paths you want in your PATH
# in the ~/.binpaths file.

add_binpaths() {
  source=$1
  addpaths=$( cat $source );
  for path in $addpaths;
  do
    PATH=$path":${PATH}"
    export PATH
  done
}

test -r ~/.binpaths && add_binpaths ~/.binpaths
test -r ~/.binpaths_host && add_binpaths ~/.binpaths_host

export EDITOR='vim'

# For those few weird cases when you have to log into someone's box by password
# and don't want to add an entry to your .ssh/config.
alias nokeyssh='ssh -o PubkeyAuthentication=no'
