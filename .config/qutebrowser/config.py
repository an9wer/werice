# Do not load autoconfig
config.load_autoconfig(False)

# Use mouse right-click to close tabs
config.set('tabs.close_mouse_button', 'right')

# Set background color of selected tabs
config.set('colors.tabs.selected.odd.bg', '#005577')
config.set('colors.tabs.selected.even.bg', '#005577')
config.set('colors.tabs.pinned.selected.odd.bg', '#005577')
config.set('colors.tabs.pinned.selected.even.bg', '#005577')

# Set backgound color of unselected tabs
config.set('colors.tabs.odd.bg', 'grey')
config.set('colors.tabs.even.bg', 'grey')
config.set('colors.tabs.pinned.odd.bg', 'darkseagreen')
config.set('colors.tabs.pinned.even.bg', 'darkseagreen')

# Allow javascript copy links to clipboard
config.set('content.javascript.can_access_clipboard', True)

# Bind f key to open links in current tab
config.bind('f', 'hint links current', mode='normal')
# Bind F key to open links in new tab
config.bind('F', 'hint links tab-fg', mode='normal')

# Bind D key to close current tab
config.bind('D', 'tab-close', mode='normal')
# Bind d key to scroll half page down
config.bind('d', 'scroll-page 0 0.5', mode='normal')

# Bind U key to restore last closed tab
config.bind('U', 'undo', mode='normal')
# Bind u key to scroll half page up
config.bind('u', 'scroll-page 0 -0.5', mode='normal')

# Bind Alt-9 key to focus the 9th tab
config.bind('<Alt-9>', 'tab-focus 9', mode='normal')
# Bind Alt-0 key to focus the last tab
config.bind('<Alt-0>', 'tab-focus -1', mode='normal')

# Bind Tab to switch to previous tab in stack
config.bind('<Tab>', 'tab-focus stack-prev', mode='normal')
# Bind Alt-Tab to switch to next tab in stack
config.bind('<Alt-Tab>', 'tab-focus stack-next', mode='normal')

# Bind Tab key to choose next item from all completions
config.bind('<Tab>', 'completion-item-focus next', mode='command')
# Bind Tab key to choose previous item from all completions
config.bind('<Alt-Tab>', 'completion-item-focus prev', mode='command')
