werice
======

My dotfiles.

Introduction
------------

My current  daily driver is **Gentoo** on the laptop **Thinkpad T14 Gen2 AMD
Ryzen 7 PRO 5850U**, and here is a list of utilties shipped on it:

- Window Manager: dwm
- Compositor: picom
- Application Launcher: dmenu
- Status Bar: slstatus
- Terminal: st
- Shell: bash
- Editor: vim/nano
- File Manager: vifm
- Note Taking: joplin
- Web Browser: firefox
- PDF Reader: zathura
- Media Player: mpv
- Input Method: ibus
- Input Method Engine: rime

Usage
-----

Simply run the below script to install all configuration files to the home
directory, then have fun to play with it: ::

    $ ./setup.sh


Other Than That
---------------

TLDR: after spending time on trying many different "new" and "awesome" tools,
what I come up with is "old is good, simple is enough".

Laptops
"""""""

TODO

Editors
"""""""

I have been a vim user for several years, and my perferred way of using vim as
an editor doesn't rely on a lot of plugins (actually I had only one plugin
installed for those years, which was `vim-system-copy`_ that provides key
mappings for copying text into clipboard), because I don't like to customize it
to become an IDE, by integrating with a lot of "useful" functions like running
git commands, searching for files, or compiling programs. I mean I can achieve
the same results simply by opening another terminal or hitting ``Ctrl-Z`` to
suspend vim for doing other tasks. In my mind, vim is strong enough that offers
an effective way to handle most of editing tasks, such as completing words,
increasing or decreasing numerical characters, modifing multiple lines at the
same time, recording macros for repeated jobs, and so on.

.. _vim-system-copy: https://github.com/christoomey/vim-system-copy
