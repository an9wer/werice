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
an editor doesn't rely on a lot of plugins (actually I only installed one
plugin for those years, which was `vim-system-copy`_ that provides key mappings
for copying text into clipboard), because I don't like to customize it to work
like an IDE, with a lot of "useful" functions that can be done in a shell as
well, like running git commands, searching files or words, or compiling
programs. In my mind, vim is strong enough that provides an effective way to
handle most of editing tasks, such as word completion increasing or decreasing
numerical characters, modifing multiple lines at the same time, recording macros
for repeated jobs, and so on.

.. _vim-system-copy: https://github.com/christoomey/vim-system-copy
