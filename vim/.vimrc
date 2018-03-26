if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" my plugin
" ----------------------------------------------------------------------------
" Plugin 'davidhalter/jedi-vim'
" Plugin 'nvie/vim-flake8'
" Plugin 'python-mode/python-mode'
"
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'

" automatic closing of quotes, parenthesis, bracket, etc.
Plugin 'Raimondi/delimitMate'

Plugin 'yonchu/accelerated-smooth-scroll'

Plugin 'terryma/vim-multiple-cursors'

" automatically update tags files
Plugin 'craigemery/vim-autotag'

" auto complete code
Plugin 'Valloric/YouCompleteMe'

" repeat motion
Plugin 'Houl/repmo-vim'
 
" extend start command *
Plugin 'inkarkat/vim-ingo-library'
Plugin 'inkarkat/vim-SearchHighlighting'

" change surroundings
Plugin 'tpope/vim-surround'

Plugin 'mbbill/undotree'
" ============================================================================

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"


" my configure
" ----------------------------------------------------------------------------
set number

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>>', '<<', etc, use 4 spaces width
set shiftwidth=4
" use the appropriate number of spaces to insert a <Tab> in insert mode
set expandtab

augroup tabwidth
    autocmd FileType sh :set tabstop=2
    autocmd FileType sh :set shiftwidth=2
    autocmd FileType sh :set expandtab
augroup END


" 80列红线
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" 改变 80 列线的颜色
" :highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
"
" ============================================================================


" keymap
" ----------------------------------------------------------------------------
" :let mapleader = ","
"
" prevent cursor from moving back one character on insert mode exit (deprecated)
"
" inoremap <silent> <Esc> <C-O>:stopinsert<CR>
" or
" :inoremap <silent> <Esc> <Esc>`^`
"
" ============================================================================


" NERDTree config
" ----------------------------------------------------------------------------
" autocmd vimenter * NERDTree
map <F2> :NERDTreeToggle<CR>
"
" ignore some file and directory
let NERDTreeIgnore=['\.pyc$[[file]]', 'venv[[dir]]']
"
" show hidden file
let NERDTreeShowHidden=1
"
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ============================================================================


" jedi-vim config   (:h jedi)
" ----------------------------------------------------------------------------
" 将自动补全按键定义为 <C-N>
" let g:jedi#completions_command = "<C-N>"
" 手动开启补全
" let g:jedi#popup_on_dot = 0
" 关闭补全时自动选择第一项
" let g:jedi#popup_select_first = 0
" 关闭自动补全 import
" let g:jedi#smart_auto_mappings = 0
" 一直保留补全时的提示窗口
" let g:jedi#auto_close_doc = 0
" 关闭当前函数的参数提示小窗口
" let g:jedi#show_call_signatures = 0
"
" ============================================================================


" easymotion config (:h easymotion)
" ----------------------------------------------------------------------------
" None
"
" ============================================================================


" ctrlp config (:h ctrlp)
" ----------------------------------------------------------------------------
" let g:ctrlp_max_history = 20
" let g:ctrlp_mruf_max = 250
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'venv',
  \ }
    
"
" ============================================================================


" YouCompleteMe config      (:h youcompleteme)
" ----------------------------------------------------------------------------
" old version
if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
endif
" new version
if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
endif

" 将跳转映射到 <leader>g 
" nnoremap <leader>g :YcmCompleter GoTo<CR>
"
" 关闭补全时的提示窗口 (preview window)
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
"
" ============================================================================


" Tagbar config     (:h tagbar)
" ----------------------------------------------------------------------------
" 按 <F10> 开启 tagbar
nmap <F10> :TagbarToggle<CR>
" 打开 tagbar 的同时光标自动跳转到 tagbar 窗口
let g:tagbar_autofocus = 1
" 修改 tagbar 中的图标显示
let g:tagbar_iconchars = ['▸', '▾']
"
" ============================================================================


" delimitMate config      (:h delimitMate)
" ----------------------------------------------------------------------------
"  None 
"
" ============================================================================


" vim-surround          (:h surround)
" ----------------------------------------------------------------------------
"  None 
"
" ============================================================================


" vim-multiple-cursors  (:h multiple-cursors)
" ----------------------------------------------------------------------------
"  None
"
" ============================================================================


" vim-SearchHighlighting  (:h SearchHighlighting)
" ----------------------------------------------------------------------------
"  None
"
" ============================================================================


" undotree      (:h undotree-contents)
" ----------------------------------------------------------------------------
nnoremap <F1> :UndotreeToggle<cr>
" 打开 undotree 的同时光标自动跳转到 undotree 窗口
let g:undotree_SetFocusWhenToggle = 1
"
" ============================================================================
