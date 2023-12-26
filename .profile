# interactive shell
if [[ $- == *i* ]]; then
	export ENV=$HOME/.kshrc

	case $(uname) in
		OpenBSD ) TTY=/dev/ttyC0 ;;
		Linux   ) TTY=/dev/tty1 ;;
	esac

	if [[ $(tty) == $TTY && -z $DISPLAY ]]; then
		exec startx
	fi
fi
