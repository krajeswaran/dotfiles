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

alias ls="ls --color"
alias vi="vim"
alias ejectusb="udisksctl power-off -b "
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
setxkbmap -option caps:escape

# pyenv
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# yarn 
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Ubuntu make installation of Ubuntu Make binary symlink
export PATH=/home/thesaneone/.local/share/umake/bin:$PATH

# Ubuntu make installation of Go Lang
export PATH=/home/thesaneone/.local/share/umake/go/go-lang/bin:$PATH
export GOROOT=/home/thesaneone/.local/share/umake/go/go-lang

# Ubuntu make installation of Nodejs Lang
export PATH=/home/thesaneone/.local/share/umake/nodejs/nodejs-lang/bin:/home/thesaneone/.npm_modules/bin:node_modules/.bin:$PATH

if [ -e /home/thesaneone/.nix-profile/etc/profile.d/nix.sh ]; then . /home/thesaneone/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# for nix pkgs
export LOCALE_ARCHIVE_2_11="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
export LOCALE_ARCHIVE_2_27="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
export LOCALE_ARCHIVE="/usr/bin/locale"

# nix aliases
function nix() {
	case $* in
		list* ) nix-env -q ;;
		search* ) shift 1; nix-env -qas "$@" ;;
		install* ) shift 1; nix-env -i "$@" ;;
		uninstall* ) shift 1; nix-env --uninstall "$@" ;;
		update* ) nix-channel --update ;;
		upgrade* ) nix-env -u ;;
		repair* ) nix-store --verify --check-contents --repair ;;
		show* ) shift 1; nix-env -qa --description ".*"$@".*" ;;
		clean* ) nix-collect-garbage -d ;;
		** ) echo "Try nix <command>\nAvailable commands: list, search, install, uninstall, update, upgrade, repair, show, clean\n"
	esac
}

export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS

