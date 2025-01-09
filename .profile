# interactive shell
if [[ $- == *i* ]]; then
	# customized settings depending on systems
	case $(uname) in
	Linux   )	export ENV=$HOME/.kshrc

			# initialize an X session with 'startx'
			if [[ $(tty) == /dev/tty1 && -z	$DISPLAY ]]; then
				export XINITRC=.xsession
				exec startx
			fi
			;;

	OpenBSD )	# the X session is started by xenodm(1)
			;;
	esac
fi
