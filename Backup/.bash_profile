# for color(has to be up front)
# for shell color
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35;01m\]\u\[\033[00;00;01m\]@\[\033[01;35;01m\]\h\[\033[00;31;01m\]:\[\033[00;00;01m\]\w \[\033[01;32;01m\]\$ \[\033[01;01;01m\]'


# for rust
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export PATH="$HOME/.cargo/bin:$PATH"

# for conda
export PATH="/home/lemon/Code_apps/Anaconda/anaconda3/bin:$PATH"

# for conda in tmux
#conda activate self-driving

# for navi widget                                                           
# source <(navi widget zsh)


# for sudo not to reset env
alias sudo='sudo env PATH=$PATH' 
