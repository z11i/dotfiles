#!/usr/bin/env sh

# === OS detection and OS specific preparations needed to proceed. === #
OS_NAME=''
LINUX_DISTRO=''
detectOS() {
	case $(uname | tr '[:upper:]' '[:lower:]') in
	linux*)
		OS_NAME=linux
		distro=$(
			(lsb_release -ds || cat /etc/*release || uname -om) 2>/dev/null |
				head -n1 |
				tr '[:upper:]' '[:lower:]'
		)
		case $distro in
		ubuntu*)
			LINUX_DISTRO=ubuntu
			;;
		*)
			echo 'Distro not supported yet!'
			exit 127
			;;
		esac
		;;
	darwin*)
		OS_NAME=macos
		;;
	#msys*)
	#	OS_NAME=windows
	#	;;
	*)
		echo 'OS not supported yet!'
		exit 127
		;;
	esac
}

detectOS

## macos preparations
if [ $OS_NAME = 'macos' ]; then
	command -v brew >/dev/null 2>&1 ||
		(
			echo === installing homeberw ===
			curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
			 
		)
	[ -e /usr/local/opt/gnu-getopt/bin/getopt ] ||
		brew install gnu-getopt # solve getopt on macos doesn't support long options
	export FLAGS_GETOPT_CMD=/usr/local/opt/gnu-getopt/bin/getopt
fi


# === functions === #
_bkup() {
	if [ ! -e "$1" ]; then
		return
	fi
	echo "backup up <<< $1"
	prefix="$1".bkup
	counter=1
	while true; do
		target="$prefix"_"$counter"
		if [ ! -e "$target" ]; then
			echo "backup to >>> $target"
			mv -- "$1" "$target"
			break
		fi
		counter=$((counter + 1))
	done
}

# usage: transfer <filename> <dir>
# example: transfer homefiles/.gitignore_global ~
# example: transfer config/fish ~/.config
transfer() {
	echo === transfering $1 ===
	dest="$2/$(basename $1)"
	_bkup $dest
	echo transfer to $dest
	if [ -f $1 ]; then
		cp $1 $dest
	elif [ -d $1 ]; then
		cp -r $1 $dest
	fi
}


# === read flags === #
. shflags/shflags

DEFINE_boolean 'all' ${FLAGS_FALSE} 'configure all tools'
DEFINE_boolean 'git' ${FLAGS_FALSE} 'configure git'
DEFINE_boolean 'fish' ${FLAGS_FALSE} 'configure fish'

FLAGS "$@" || exit $?
eval set -- "${FLAGS_ARGV}"
YES=${FLAGS_TRUE}
NO=${FLAGS_FALSE}


# === setup git === #
if [ ${FLAGS_git} -eq $YES ] || [ ${FLAGS_all} -eq $YES ]; then
	transfer homefiles/.gitignore_global ~
	transfer homefiles/.gitconfig ~
	if [ $OS_NAME = 'macos' ]; then
		brew install git
	fi
fi


# === setup fish === #
if [ ${FLAGS_fish} -eq $YES ] || [ ${FLAGS_all} -eq $YES ]; then
	mkdir -p ~/.config
	transfer config/fish ~/.config
	case $OS_NAME in
	linux)
		case $LINUX_DISTRO in
		ubuntu)
			sudo apt-add-repository -y ppa:fish-shell/release-3
			sudo apt-get update -y
			sudo apt-get install -y fish
			;;
		esac
		;;
	macos)
		brew install fish
		;;
	esac
fi
