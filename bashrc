#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Modified Commands
#alias diff='vimdiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='vim'
alias ping='ping -c 5'
alias ..='cd ..'
alias ls='ls --color=auto'
alias update='yaourt -Syu --aur'
alias rm='rm -v'

# New Commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'      # requires an argument
alias openports='netstat --all --numeric --programs --inet --inet6'
alias la='ls -la'
alias :q='exit'
alias :wq='exit'
alias aur='cower -ddfu --target=/home/sauron/builds/'
alias alert='beep -f 5000 -l 60 -r 2'
alias configwget='time ./configure --enable-option-checking --disable-silent-rules --enable-dependency-tracking --with-ssl=openssl --without-included-regex CFLAGS="-g -O0"'
alias parallelconfig='configwget --enable-metalink --enable-threads=posix'
alias run='time ./runTest.py'
alias proj='cd ~/Programming/wget-gsoc/testenv'
alias resetproj='./bootstrap && configwget'

# Safety Features
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias sudo='sudo '
#alias pacman='pacsrv'

export FIGNORE=$FIGNORE:.aux:.bbl:.blg:.toc:

# Privileged Access
if [ $UID -ne 0 ]; then
    alias svim='sudo vim'
    alias kdm='sudo kdm'
    alias srm='sudo rm'
    alias scp='sudo cp'
fi

pastebin() { curl -F 'f:1=<-' ix.io; }

function /bin/rm() { command rm "-i""$@"; }

#sudo() { if [[ $@ == "pacman -Syu" ]]; then command pacup.sh; else command sudo "$@"; fi; }

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend
shopt -s dotglob
shopt -s expand_aliases
shopt -s nocaseglob
shopt -s extglob
shopt -s checkjobs
shopt -s dirspell


set show-all-if-ambiguous on

pdflatex() {
GREP="grep --color=always --line-buffered"
LL=$*
echo $LL
(/usr/bin/pdflatex -file-line-error "$LL" 2>&1) \
 | $GREP -vP "^\s*((\[|\]|\(|\))\s*)+$" \
 | GREP_COLOR="01;31" $GREP -P "(^[^:]*:\d+: )|(^l\.\d+ )|(^! LaTeX Error: )|$" \
 | GREP_COLOR="00;33" $GREP -P "(LaTeX Warning(:|))|(Package [^\s]+ Warning(:|))|$" \
 | GREP_COLOR="00;32" $GREP -P "^Output written on .*\.pdf \(.*\)\.$|$" \
 | uniq
}

extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
        *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
               c='bsdtar xvf';;
        *.7z)  c='7z x';;
        *.Z)   c='uncompress';;
        *.bz2) c='bunzip2';;
        *.exe) c='cabextract';;
        *.gz)  c='gunzip';;
        *.rar) c='unrar x';;
        *.xz)  c='unxz';;
        *.zip) c='unzip';;
        *)     echo "$0: unrecognized file extension: \`$i'" >&2
               continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}

pack() {
  local FILE
  FILE=$1
  case $FILE in
    *.tar.bz2)  shift && tar cjf $FILE $* ;;
    *.tbz2)     shift && tar cjf $FILE $* ;;
    *.tar.gz)   shift && tar czf $FILE $* ;;
    *.tgz)      shift && tar czf $FILE $* ;;
    *.zip)      shift && zip $FILE $*     ;;
    *.rar)      shift && rar $FILE $*     ;;
  esac
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
    }

# A Little Note Taker
note ()
{
       #if file doesn't exist, create it
       [ -f $HOME/.notes ] || touch $HOME/.notes
       #no arguments, print file
       if [ $# = 0 ]
       then
               cat $HOME/.notes
       #clear file
       elif [ $1 = -c ]
       then
               > $HOME/.notes
       #add all arguments to file
       else
               echo "$@" >> $HOME/.notes
       fi
}


# cd and ls in one
cl() {
if [ -d "$1" ]; then
        cd "$1"
        ls -la
        else
        echo "bash: cl: '$1': Directory not found"
fi
}



source "/usr/share/doc/pkgfile/command-not-found.bash"
source "/usr/share/git/completion/git-prompt.sh"

GIT_PS1_SHOWDIRTYSTATE=1;
GIT_PS1_SHOWCOLORHINTS=1;
GIT_PS1_SHOWUNTRACKEDFILES=1;

SH_WHITE="\[\033[1;37m\]"
SH_BLUE="\[\033[1;34m\]"
SH_RED="\[\033[1;31m\]"
SH_GREEN="\[\033[1;32m\]"
SH_YELLOW="\[\033[1;33m\]"

BL_ANGLE="\342\224\224"
TL_ANGLE="\342\224\214"
HORIZ_LINE="\342\224\200"
BATT="\$(acpi -b | awk '{print \$4}' | cut -b1-3)"
FILES_STAT="\$(ls -1 | wc -l | sed 's: ::g')"

if [ $UID -eq 0 ]; then
PS1='\[\e[0;31m\]\u\[\e[m\]\[\e[1;37m\]@\h\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;32m\]'
else
PS1="\n"${SH_WHITE}${TL_ANGLE}"("${SH_BLUE}"\u"${SH_WHITE}"@"${SH_RED}"\h"${SH_WHITE}")"${HORIZ_LINE}"("${SH_GREEN}"\$?"${SH_WHITE}")"${HORIZ_LINE}"("${SH_GREEN}${BATT}${SH_WHITE}")"${HORIZ_LINE}"("${SH_GREEN}"\@ \d"${SH_WHITE}")\n"${BL_ANGLE}${HORIZ_LINE}"("${SH_GREEN}"\w"${SH_WHITE}")"${HORIZ_LINE}"("${SH_YELLOW}${FILES_STAT}" files, \$(ls -lah | grep -m 1 total | sed 's/1:total //')b\[\033[1;37m\])\342\224\200\[\033[1;34m\]"'$(__git_ps1 "(%s)")'"\[\033[1;37m\]> \[\033[1;32m\]"
fi
trap 'echo -ne "\e[0m"' DEBUG
PS2='>> '
PS3='>>> '
PS4='+ '
#PS1='[\u@\h \W]\$ '

export PERL_LOCAL_LIB_ROOT="/home/sauron/perl5";
export PERL_MB_OPT="--install_base /home/sauron/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/sauron/perl5";
export PERL5LIB="/home/sauron/perl5/lib/perl5/x86_64-linux-thread-multi:/home/sauron/perl5/lib/perl5";
export PATH="/home/sauron/perl5/bin:$PATH";

export EDITOR=vim;
export VISUAL=vim;
export TERM=xterm-256color;
