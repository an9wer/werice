# interactive shell
if [[ $- == *i* ]]; then
	export ENV=$HOME/.kshrc
	if [[ $(tty) == /dev/tty1 && -z $DISPLAY ]]; then
		exec startx
	fi
fi
