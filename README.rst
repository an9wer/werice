werice
======

My dotfiles.

Usage
-----

A shell script is provided to install all dotfiles into the ``$HOME`` directory: ::

	$ ./setup

Note that:

- the setup script is POSIX compliant, which means it be executed by various
  shells, such as bash and ksh.
- the setup script installs dotfiles by creating a symbolic link for each of
  them.
- the setup script will not delete any existed dotfiles, instead it will backup
  them first by adding a ``.orig`` suffix.

Introduction to my Workflow
---------------------------

Summary: After investing time in exploring various "new" and "awesome" tools,
what I have concluded is that simplicity is sufficient, which also matches `the
philosophy of suckless <https://suckless.org/philosophy/>`_. Thus, the tools
of my choice should be simple, minimal and usable, and here is a list of
them that align with my preferences:

- Operating System: Gentoo/OpenBSD
- Window Manager: dwm
- Compositor: picom
- Application Launcher: dmenu
- Status Bar: slstatus
- Terminal: st
- Shell: bash/ksh
- Editor: vim/nano
- File Manager: vifm
- Note Taking: joplin
- Web Browser: firefox
- PDF Reader: zathura
- Media Player: mpv
- Input Method: ibus
- Input Method Engine: rime

Laptops
"""""""

As of now, I am using a Thinkpad laptop - T14 Gen2 AMD Ryzen 7 PRO 5850U.

Editors
"""""""

I have been a vim user for several years. In my mind, vim is strong enough that
offers an effective way to handle most of editing tasks, such as completing
words, increasing or decreasing numerical characters, modifing multiple lines at
the same time, recording macros for repeated jobs, and so on.

The way I used to using vim as an editor doesn't rely on a lot of plugins
(actually I had only one plugin installed for those years, which was
`vim-system-copy`_ that provides key mappings for copying text into clipboard),
because I don't like to customize it to become an IDE, by integrating with a lot
of "useful" functions like running git commands, searching for files, or
compiling programs. Instead, I could achieve the same results simply by opening
another terminal or hitting `Ctrl-Z` to suspend vim for doing other tasks.

Personally, I prefer to write vim plugins by myself, so that I can confidently
know how they work - actually I did write a few `vim plugins`_. However, writing
and maintaining vim plugins were quite tough to me, because the language of vim
scripts was a large topic and not easy to start with, and I had neither the time
nor the determination to be familiar with it frequently.

So I quit vim and embraced nano.

.. _vim-system-copy: https://github.com/christoomey/vim-system-copy
.. _vim plugins: https://github.com/an9wer/werice/tree/0ffaeb63d758d1b72f39d51b72598b28c4e95eac/.vim/plugin
