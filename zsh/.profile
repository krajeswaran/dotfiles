## proxy stuff
#proxy_on()
#    export no_proxy='localhost'
#    export http_proxy="http://localhost:3128"
#    export https_proxy=$http_proxy
#    export ftp_proxy=$http_proxy
#    export HTTP_PROXY=$http_proxy
#    export HTTPS_PROXY=$http_proxy
#}
#
#proxy_off() {
#    unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY ftp_proxy
#}
#
#proxy_on # proxy on by default

############ OS ALIASES ######################

alias ejectusb="udisksctl power-off -b "
alias kssh="kitty +kitten ssh"
alias kiv="kitty +kitten icat "
alias restart_kde="export DISPLAY=:0; killall plasmashell; kwin --replace & kstart5 plasmashell & exit"
alias vi='nvim'
alias vik='NVIM_APPNAME="nvim-ks" nvim'

############ OS ENV ######################
# export JAVA_HOME=/Library/Java/Home
# export GRAILS_HOME=${HOME}/src/grails-2.4.3
# export GEM_PATH=${HOME}/.gem/ruby/2.0.0
#export GRADLE_HOME=${HOME}/src/gradle

export ANDROID_HOME=${HOME}/src/android-sdk
export ANDROID_SDK_ROOT=${HOME}/src/android-sdk
export GOPATH=${HOME}/gopath
export NODE_PATH=${HOME}/.node/lib/node_modules:$NODE_PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=/usr/sbin:/usr/local/bin:${GRADLE_HOME}/bin:${ANDROID_HOME}/emulator:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_HOME}/cmdline-tools/latest/bin:${GEM_PATH}/bin:${HOME}/bin:${GRAILS_HOME}/bin:${GOPATH}/bin:${HOME}/.node/bin:${HOME}/.local/bin:${HOME}/.maestro/bin:${PATH}
export MANPATH=${HOME}/.node/share/man:${MANPATH}
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
export EDITOR='vi'
export USE_CCACHE=1
export CCACHE_COMPRESS=1
#export LD_LIBRARY_PATH=${ANDROID_SDK_ROOT}/emulator/lib64:${ANDROID_SDK_ROOT}/emulator/lib64/qt/lib
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

xo() {
  xdg-open "$@" 2>/dev/null
}

# replace caps with escape
setxkbmap -option caps:escape

# # asdf vm stuff
# . $HOME/.asdf/asdf.sh

# # append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)

# brew stuff
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

command -v lsd >/dev/null 2>&1 && alias ls="lsd"

# for node 18
export PATH="/home/linuxbrew/.linuxbrew/opt/node@18/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/node@18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/node@18/include"
export MOZ_USE_XINPUT2=1
