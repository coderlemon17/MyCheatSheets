##########################################################
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

#__conda_setup="$('/home/lemon/Code_apps/Anaconda/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/lemon/Code_apps/Anaconda/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/lemon/Code_apps/Anaconda/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/lemon/Code_apps/Anaconda/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup

# <<< conda initialize <<<

# export PATH="/home/lemon/Code_apps/Anaconda/anaconda3/bin:$PATH"

# for sudo not to reset env
alias sudo='sudo env PATH=$PATH'

# for navi widget
# cannot work, because tab will be used
# source <(navi widget zsh)

# for qemu
# export PATH=/home/lemon/Code_apps/Qemu/qemu-4.2.0/riscv32-softmmu:/home/lemon/Code_apps/Qemu/qemu-4.2.0/riscv64-softmmu:$PATH

# for rust
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
# export PATH="$HOME/.cargo/bin:$PATH"


# for CUDA
export PATH="/usr/local/cuda-11.2/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-11.2/lib64:$LD_LIBRARY_PATH"

# for Java
# export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# export JRE_HOME="${JAVA_HOME}/jre"
# export CLASSPATH=".:${JAVA_HOME}/lib:${JRE_HOME}/lib"
# export PATH="${PATH}:${JAVA_HOME}/bin"

# Load pyenv automatically by adding
# the following to ~/.bashrc:

export PATH="/home/lemon/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# for free_mjc: https://github.com/Lemoners/free_mjc
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.mujoco/mujoco200/bin
# for mujoco
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libGLEW.so
##########################################################



# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lemon/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	jump
	zsh-autosuggestions
	zsh-syntax-highlighting
	git-prompt
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# zsh autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#conda activate self-drivingi
export VVENV="/home/lemon/Environments"
#source $VVENV/basic_env/bin/activate
source $VVENV/spinning_env/bin/activate
#source $VVENV/atla_env/bin/activate

# encoding
export LC_ALL=en_US.utf-8 
export LANG="$LC_ALL" 

# exports
export EDITOR=vim

# for vim
export TERM=xterm-256color
bindkey -v
export KEYTIMEOUT=1
# So delete will always work
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Edit line in vim with ctrl-e:
# autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# useful alias
alias cls="clear"
alias mzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias n="navi"
alias np="navi --print"
alias clean="sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'"
alias weather="curl wttr.in"
alias boom="cmatrix"
alias tweaks="gnome-tweaks"
alias mcom="cat ~/.zsh_history | cut -c 16- | tr -s '\n' | uniq | fzf | xsel --clipboard"
alias chrome="google-chrome"
alias shot="flameshot gui"
alias vpn="mclashy 1>/dev/null 2>&1 &"
jpls() {
	jump "${1}";
	ls;
}
alias j="jpls"

mokular() {
	okular "${1}"	>/dev/null 2>&1 &;
}
alias ok="mokular"

mtypora() {
	typora "${1}"   >/dev/null 2>&1 &;
}
alias ty="mtypora"


mcdls() {
	cd "${1}";
        ls;
}
alias cl='mcdls'

alias xc="xsel --clipboard"

# for i3wm
alias lk="i3lock-fancy 2>/dev/null"
# alias f="ranger"
# alias net="nmtui"
# alias psound="alsamixer"
alias sound="pavucontrol"
# alias xm="xmodmap ~/Workspace/myCheatSheet/i3wm/Scripts/Xmodmap"
# alias minit="bash ~/Workspace/myCheatSheet/i3wm/Scripts/startup.sh"
# alias ldown="sudo light -U 20"
# alias lup="sudo light -A 20"

# vritualenvironment
alias vv="virtualenv"
msvv() {
    source $VVENV/$1/bin/activate;
}
alias svv="msvv"
alias dvv="deactivate"

alias bilibili="mbilibili"
mbilibili () {
    echo "GO TO STUDY!!!";
}

alias dk="du -h --max-depth=1"

eval 
            fuck () {
                TF_PYTHONIOENCODING=$PYTHONIOENCODING;
                export TF_SHELL=zsh;
                export TF_ALIAS=fuck;
                TF_SHELL_ALIASES=$(alias);
                export TF_SHELL_ALIASES;
                TF_HISTORY="$(fc -ln -10)";
                export TF_HISTORY;
                export PYTHONIOENCODING=utf-8;
                TF_CMD=$(
                    thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
                ) && eval $TF_CMD;
                unset TF_HISTORY;
                export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
                test -n "$TF_CMD" && print -s $TF_CMD
            }
        
# for broot
# source /home/lemon/.config/broot/launcher/bash/br

# for preview help information in vim
mvp() {
    vim <($@ 2>&1);
}
alias vp=mvp

# ask before overwrite
alias mv="mv -i"

# file explorer
alias fileexplore="nautilus"

# calendar
alias cur="cal $(date | cut -d " " -f 2,6)"

# display computer info
alias info="screenfetch"

# find all lsyncd process
alias syncs="ps -aux | grep lsyncd"

# kb alias
alias kbl="kb list"
alias kbe="kb edit --id"
alias kba="kb add"
alias kbv="kb view --id"
alias kbd="kb delete --id"
alias kbg="kb grep"
alias kbt="kb list --tags"
alias lg="lazygit"

# move files from downloads
mmfd() {
    mv ~/Downloads/$1 $2
}
alias mfd="mmfd"

# brightness controller
alias br="brightness-controller"
