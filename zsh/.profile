# export JAVA_HOME=/Library/Java/Home
# export GRAILS_HOME=${HOME}/src/grails-2.4.3
export ANDROID_HOME=${HOME}/src/android-sdk
export GRADLE_HOME=${HOME}/src/gradle
# export GEM_PATH=${HOME}/.gem/ruby/2.0.0
export GOPATH=${HOME}/gopath
export NODE_PATH=${HOME}/.node/lib/node_modules:$NODE_PATH

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

alias ls="lsd"
alias vi="nvim"
alias ejectusb="udisksctl power-off -b "
alias fd="fdfind"
export PATH=/usr/sbin:/usr/local/bin:${GRADLE_HOME}/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${GEM_PATH}/bin:${HOME}/bin:${GRAILS_HOME}/bin:${GOPATH}/bin:${HOME}/.node/bin:${HOME}/.local/bin:${PATH}
export MANPATH=${HOME}/.node/share/man:${MANPATH}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

xo() {
	xdg-open "$@" 2>/dev/null
}

function docker_prune() {
	docker system df
	docker container prune
	docker image prune
}

export USE_CCACHE=1
export CCACHE_COMPRESS=1
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

# replace caps with escape
#setxkbmap -option caps:escape

# yarn 
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

autoload -Uz compinit
compinit
