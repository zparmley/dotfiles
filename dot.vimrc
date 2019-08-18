" My daily driver

" use .vim even on windows {
    set rtp+=~/.vim
" }

" vundle initialization and options {
    set nocompatible              " be iMproved, required
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
" }

" display options {
    syntax on               "syntax coloring is a first-cut debugging tool
    colorscheme elflord     "change to taste. try `desert' or `evening'

    set wrap                "wrap long lines
    set scrolloff=3         "keep three lines visible above and below
    set ruler showcmd       "give line, column, and command in the status line
    set laststatus=2        "always show the status line
                            "make filename-completion more terminal-like
    set wildmode=longest:full
    set wildmenu            "a menu for resolving ambiguous tab-completion
                            "files we never want to edit
    set wildignore=*.pyc,*.sw[pno],.*.bak,.*.tmp

    set incsearch           "search as you type
    set hlsearch            "highlight the search
    set ignorecase          "ignore case
    set smartcase           " ...unless the search uses uppercase letters
" }

" movement options {
    "enable mouse in normal, visual, help, prompt modes
    "I skip insert/command modes because it prevents proper middle-click pasting
    "TODO: can we get paste to work even with mouse enabled?
    set mouse=nvrh

    " Moving up/down moves visually.
    " This makes files with very long lines much more manageable.
    nnoremap j gj
    nnoremap k gk
    " Moving left/right will wrap around to the previous/next line.
    set whichwrap=b,s,h,l,<,>,~,[,]
    " Backspace will delete whatever is behind your cursor.
    set backspace=indent,eol,start

    "Bind the 'old' up and down. Use these to skip past a very long line.
    noremap gj j
    noremap gk k
" }

" general usability {
    "turn off the annoying 'ding!'
    set visualbell

    "allow setting extra option directly in files
    "example: "vim: syntax=vim"
    set modeline

    "don't clobber the buffer when pasting in visual mode
    vmap P p
    vnoremap p "_dP
    
    "Spell check language
    set spelllang=en
" }

" common typos {
    "never use Ex mode -- I never *mean* to press it
    nnoremap Q <ESC>
" }

" multiple files {
    " be smarter about multiple buffers / vim instances
    set hidden
    set autoread            "auto-reload files, if there's no conflict
    set shortmess+=IA       "no intro message, no swap-file message

    "replacement for CTRL-I, also known as <tab>
    noremap <C-P> <C-I>

    "window switching: ctrl+[hjkl]
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-H> <C-W>h
    nnoremap <C-L> <C-W>l
    nnoremap <C-Q> <C-W>q

    " tab switching: tab/shift-tab
    nnoremap <TAB> :tabn<CR>
    nnoremap <S-TAB> :tabp<CR>
" }

"indentation options {
    set expandtab                       "use spaces, not tabs
    set softtabstop=4 shiftwidth=4      "4-space indents


    set shiftround                      "always use a multiple of 4 for indents
    set smarttab                        "backspace to remove space-indents
    set autoindent                      "auto-indent for code blocks
    "DONT USE: smartindent              "it does stupid things with comments

    "smart indenting by filetype, better than smartindent
    filetype on
    filetype indent on
    filetype plugin on
" }

" vundle plugins and end {
    if filereadable(expand('~/.vim/VundlePlugins.vimrc'))
        source ~/.vim/VundlePlugins.vimrc
    endif

    call vundle#end()            " required
    filetype plugin indent on    " required
" }

" Syntax highlighting settings {
    let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" }

" Syntax airline settings {
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'
"}
