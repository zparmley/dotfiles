""" set $DEV_VIMRC_PREFIX to load an alternate .vimrc
""" if $DEV_VIMRC_PREFIX is set, $HOME/$DEV_VIMRC_PREFIX.vimrc is sourced
""" and the body of this vimrc is skipped



if empty($DEV_VIMRC_PREFIX)
    """ neovim shared python3 venv
    " if has('nvim')
    "     let g:python3_host_prog = '/Users/zacharyparmley/PERSONAL/SharedVenvs/neovim/bin/python'
    " endif

    """ Before plugins loaded
    " Using a local plugin for openscad
    let g:polyglot_disabled = ['openscad']


    """ Formatting and many options largly stolen

    """ Automatically create needed files and folders on first run (*nix only) {{{
    call system('mkdir -p $HOME/.vim/{autoload,bundle,swap,undo}')
    """ }}}

    """ vim-plug plugin manager {{{
    " Automatic installation
    " https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
    if empty(glob('~/.vim/autoload/plug.vim'))
        let g:clone_details = 'https://github.com/junegunn/vim-plug.git $HOME/.vim/bundle/vim-plug'
        silent call system('git clone --depth 1 '. g:clone_details)
        if v:shell_error | silent call system('git clone ' . g:clone_details) | endif
        silent !ln -s $HOME/.vim/bundle/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim
        augroup FirstPlugInstall
            autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
        augroup END
    endif

    """ Plugins to be disabled {{{
    """ https://github.com/timss/vimconf/issues/13
    " Create empty list with names of disabled plugins if not defined
    let g:plugs_disabled = get(g:, 'plug_disabled', [])

    " Trim and extract repo name
    " Same substitute/fnamemodify args as vim-plug itself
    " https://github.com/junegunn/vim-plug/issues/469#issuecomment-226965736
    function! s:plugs_disable(repo)
        let l:repo = substitute(a:repo, '[\/]\+$', '', '')
        let l:name = fnamemodify(l:repo, ':t:s?\.git$??')
        call add(g:plugs_disabled, l:name)
    endfunction

    " Append to list of repo names to be disabled just like they're added
    " UnPlug 'junegunn/vim-plug'
    command! -nargs=1 -bar UnPlug call s:plugs_disable(<args>)
    """ }}}

    " Default to same plugin directory as vundle etc
    call plug#begin('~/.vim/bundle')

    """ Add Plugins {{{
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug '~/PERSONAL/Projects/NvimPythonHelpers', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'roxma/vim-hug-neovim-rpc'
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
    endif
    let g:deoplete#enable_at_startup = 1
    " Glorious colorscheme
    " To avoid errors during automatic installation
    " https://github.com/junegunn/vim-plug/issues/225
    " Plug 'nanotech/jellybeans.vim'

    " https://github.com/haystackandroid/stellarized
    " Plug 'haystackandroid/stellarized'
    
    " Let's try some catppuccin
    Plug 'catppuccin/vim', { 'as': 'catppuccin' }

    " Plug 'TroyFletcher/vim-colors-synthwave'

    " All the languages
    Plug 'sheerun/vim-polyglot'

    Plug 'davidhalter/jedi-vim'
    Plug 'deoplete-plugins/deoplete-jedi'

    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'dense-analysis/ale'

    " Plug 'udalov/kotlin-vim'
    " Plug 'sudar/vim-arduino-syntax'
    " Plug 'sirtaj/vim-openscad'
    
    Plug 'mlaga97/vim-openscad-bosl2'
    " Using a locally edited version of vim-openscad
    " Plug '~/_Projects/vim-openscad'
    " Plug 'hdiniz/vim-gradle'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'ryanoasis/vim-devicons'
    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    Plug 'tpope/vim-commentary'

    " Plug '~/PERSONAL/Projects/VimPythonFunctionsPlugin'

    " Plug 'sirver/ultisnips'
    " let g:UltiSnipsExpandTrigger = "<s-tab>"
    " let g:UltiSnipsListSnippets='<c-space>'

    " Functions, class data etc.
    " depends on either exuberant-ctags or universal-ctags
    if executable('ctags-exuberant') || executable('ctags')
        Plug 'majutsushi/tagbar'
    endif


    """ }}}

    " Remove disabled plugins from installation/initialization
    " https://vi.stackexchange.com/q/13471/5070
    call filter(g:plugs, 'index(g:plugs_disabled, v:key) == -1')

    " Initalize plugin system
    call plug#end()
    """ }}}

    """ User interface {{{
    """ Syntax highlighting {{{
    " https://stackoverflow.com/a/33380495/1076493
    if !exists('g:syntax_on')
        syntax enable
    endif

    " let g:jellybeans_overrides = {
    "             \    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
    "             \    'SignColumn': { 'ctermbg': 'none', '256ctermbg': 'none', 'guibg': 'none' },
    "             \    'CursorLine': { 'ctermbg': '235'},
    "             \}

    """ jellybeans
    " silent! colorscheme jellybeans
    
    """ catppuccin_(latte|frappe|macchiato|mocha)
    colorscheme catppuccin_macchiato

    """ stellarized light
    " set background=light
    " colorscheme stellarized

    """ Force behavior and filetypes, and by extension highlighting {{{
    augroup FileTypeRules
        autocmd!
        autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
        autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
        autocmd BufNewFile,BufRead ~/.config/zprofile/0* set ft=zsh
    augroup END
    """ }}}

    """ 256 colors for maximum jellybeans bling. See commit log for info {{{
    " if (&term =~# 'xterm') || (&term =~# 'screen')
    "     set t_Co=256
    " endif
    """ }}}
    """ }}}

    """ Interface general {{{
    set cursorline                              " hilight cursor line
    " highlight CursorLine ctermbg=White term=none cterm=none
    set more                                    " ---more--- like less
    set number                                  " line numbers
    set ruler showcmd                           " give line, column, and command in the status line
    set scrolloff=5                             " lines above/below cursor
    set showcmd                                 " show cmds being typed
    set title                                   " window title
    set vb t_vb=                                " disable beep and flashing
    set termguicolors                           " All them colors

    """ Depending on your setup you may want to enforce UTF-8. {{{
    """ Should generally be set in your environment LOCALE/$LANG
    " set encoding=utf-8                    " default $LANG/latin1
    " set fileencoding=utf-8                " default none
    """ }}}

    """ Gvim {{{
    set guifont=Cousine\ Nerd\ Font\ Mono
    set guioptions-=m                       " remove menubar
    set guioptions-=T                       " remove toolbar
    set guioptions-=r                       " remove right scrollbar
    """ }}}
    """ }}}
    """ Interface Functions {{{
    """ }}}
    """ }}}

    """ General settings {{{
    set completeopt=menu,preview,longest            " insert mode completion
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <Tab>
    set list                                        " displaying listchars
    set modeline                                    " allow files to specify own options
    set modelines=1                                 " but like, get to it
    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode cmd line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set spelllang=en                                " spell check language
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttyfast                                     " for faster redraws etc
    " set ttymouse=xterm2                             " experimental
    set whichwrap=b,s,h,l,<,>,~,[,]                 " left / right wraps to prev/next line

    """ Folding {{{
    set foldcolumn=0                            " hide folding column
    set foldmethod=indent                       " folds using indent
    set foldnestmax=10                          " max 10 nested folds
    set foldlevelstart=99                       " folds open by default
    """ }}}

    """ Search and replace {{{
    set gdefault                                " default s//g (global)
    set incsearch                               " "live"-search
    """ }}}

    """ Matching {{{
    set matchtime=2                             " time to blink match {}
    set matchpairs+=<:>                         " for ci< or ci>
    set showmatch                               " tmpjump to match-bracket
    """ }}}

    """ Wildmode/wildmenu command-line completion {{{
    set wildignore+=*.bak,*.swp,*.swo
    set wildignore+=*.a,*.o,*.so,*.pyc,*.class
    set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.pdf
    set wildignore+=*/.git*,*.tar,*.zip
    set wildmenu
    set wildmode=longest:full,list:full
    """ }}}

    """ Return to last edit position when opening files {{{
    augroup LastPosition
        autocmd! BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \     exe "normal! g`\"" |
                    \ endif
    augroup END
    """ }}}
    """ }}}

    """ Files {{{
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups

    """ Persistent undo. Requires Vim 7.3 {{{
    if has('persistent_undo') && exists('&undodir')
        if has('nvim')
            set undodir=$HOME/.vim/nvim_undo/       " where to store undofiles
        else
            set undodir=$HOME/.vim/undo/            " where to store undofiles
        endif
        set undofile                            " enable undofile
        set undolevels=500                      " max undos stored
        set undoreload=10000                    " buffer stored undos

    endif
    """ }}}

    """ Swap files, unless vim is invoked using sudo {{{
    """ https://github.com/tejr/dotfiles/blob/master/vim/vimrc
    if !strlen($SUDO_USER)
        set directory^=$HOME/.vim/swap//        " default cwd, // full path
        set swapfile                            " enable swap files
        set updatecount=50                      " update swp after 50chars

        """ Don't swap tmp, mount or network dirs {{{
        augroup SwapIgnore
            autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                        \ setlocal noswapfile
        augroup END
        """ }}}

    else
        set noswapfile                          " dont swap sudo'ed files
    endif
    """ }}}
    """ }}}

    """ Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    "set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " indents <Tab> as spaces
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " round indent of 'sw'
    set shiftwidth=0                                " =0 uses 'ts' value
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=-1                              " =-1 uses 'sw' value
    set tabstop=4                                   " <Tab> as 4 spaces indent
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab


    """ Only auto-comment newline for block comments {{{
    augroup AutoBlockComment
        autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
    augroup END
    """ }}}

    """ Take comment leaders into account when joining lines, :h fo-table {{{
    """ http://ftp.vim.org/pub/vim/patches/7.3/7.3.541
    if has('patch-7.3.541')
        set formatoptions+=j
    endif
    """ }}}
    """ }}}

    """ Keybindings and Commands {{{
    """ General {{{
    " Remap <Leader>
    let g:mapleader=','

    " Quickly edit/source .vimrc
    command! VE :edit $MYVIMRC
    command! VS :source $MYVIMRC

    " Toggle pastemode, doesn't indent
    " set pastetoggle=<F3>

    " Toggle folding
    " http://vim.wikia.com/wiki/Folding#Mappings_to_toggle_folds
    nnoremap <silent> <Leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

    " Toggle relativenumber
    nnoremap <silent> <Leader>r :set relativenumber!<CR>

    " Treat wrapped lines as normal lines
    nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
    nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

    " Quickly switch windows
    nnoremap <Leader><Up> :wincmd k<CR>
    nnoremap <Leader><Right> :wincmd l<CR>
    nnoremap <Leader><Down> :wincmd j<CR>
    nnoremap <Leader><Left> :wincmd h<CR>

    " Highlight last inserted text
    nnoremap gV '[V']

    " Preserve the yanked buffer when pasting in visual mode
    vmap P p
    vnoremap p "_dP

    " Ex mode is almost always a mistake
    nnoremap Q <ESC>

    " tab switching with tab/shift-tab
    nnoremap <TAB> :tabn<CR>
    nnoremap <S-TAB> :tabp<CR>
    """ }}}

    """ Functions and/or fancy keybinds {{{
    
        """ Split python multiple-import into seperate single imports {{{
        function! SplitPythonMultiImport()
            let line = getline('.')
            let parts = split(line, 'import ')
            let startline = parts[0]
            let mports = split(parts[1], ', ')
            for i in mports
                let newline = startline . "import " . i
                call append('.', newline)
            endfor
            execute "normal! dd"
        endfunction
        nnoremap <Leader>pp :call SplitPythonMultiImport()<CR>
        """ }}}
        
        """ Toggle syntax highlighting {{{
        function! ToggleSyntaxHighlighthing()
            if exists('g:syntax_on')
                syntax off
            else
                syntax enable
            endif
        endfunction

        nnoremap <Leader>s :call ToggleSyntaxHighlighthing()<CR>
        """ }}}

        """ Highlight characters past 79, toggle with <Leader>h {{{
        """ You might want to override this function and its variables with
        """ your own in .vimrc which might set for example colorcolumn or
        """ even the textwidth. See https://github.com/timss/vimconf/pull/4
        let g:overlength_enabled = 0
        highlight OverLength ctermbg=238 guibg=#444444

        function! ToggleOverLength()
            if g:overlength_enabled == 0
                match OverLength /\%79v.*/
                let g:overlength_enabled = 1
                echo 'OverLength highlighting turned on'
            else
                match
                let g:overlength_enabled = 0
                echo 'OverLength highlighting turned off'
            endif
        endfunction

        nnoremap <Leader>h :call ToggleOverLength()<CR>
        """ }}}
        """ Toggle text wrapping, wrap on whole words {{{
        """ For more info see: http://stackoverflow.com/a/2470885/1076493
        function! WrapToggle()
            if &wrap
                set list
                set nowrap
            else
                set nolist
                set wrap
            endif
        endfunction

        nnoremap <Leader>w :call WrapToggle()<CR>
        """ }}}
        """ Remove multiple empty lines {{{
        function! DeleteMultipleEmptyLines()
            g/^\_$\n\_^$/d
        endfunction

        nnoremap <Leader>ld :call DeleteMultipleEmptyLines()<CR>
        """ }}}
        """ Strip trailing whitespace, return to cursor at save {{{
        function! StripTrailingWhitespace()
            let l:save = winsaveview()
            %s/\s\+$//e
            call winrestview(l:save)
        endfunction

        augroup StripTrailingWhitespace
            autocmd!
            autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex,yaml
                        \ autocmd BufWritePre <buffer> :call
                        \ StripTrailingWhitespace()
        augroup END

        nnoremap <Leader>s<Space> :call StripTrailingWhitespace()<CR>
        """ }}}

        """ Smart tab in insert mode {{{
        """ - try to insert tabs when appropraite, else autocomplete
        """ https://vim.fandom.com/wiki/Smart_mapping_for_tab_completion
        function! Smart_TabComplete()
            let line = getline('.')                         " current line

            let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                            " line to one character right
                                                            " of the cursor
            let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
            if (strlen(substr)==0)                          " nothing to match on empty string
                return "\<tab>"
            endif
            let has_period = match(substr, '\.') != -1      " position of period, if any
            let has_slash = match(substr, '\/') != -1       " position of slash, if any
            if (!has_period && !has_slash)
                return "\<C-X>\<C-P>"                         " existing text matching
            elseif ( has_slash )
                return "\<C-X>\<C-F>"                         " file matching
            else
                return "\<C-X>\<C-O>"                         " plugin matching
            endif
        endfunction

        inoremap <tab> <c-r>=Smart_TabComplete()<CR>
        """ }}}
    """ }}}


    """ {{{ DEVELOPMENT Area
    """ functions and key bindings I'm working on, will eventually be moved
    """ try to stick t key byndings like <Leader>DDDx where x can relate to
    """ the work in progress, but DDD is literl to namespace indev stuff
    " tabline
    let g:tabline_set = 0
    function! Tabline()
        let s = ''
        for i in range(tabpagenr('$'))
            let tab = i + 1
            let winnr = tabpagewinnr(tab)
            let buflist = tabpagebuflist(tab)
            let bufnr = buflist[winnr - 1]
            let bufname = bufname(bufnr)
            let bufmodified = getbufvar(bufnr, "&mod")

            let s .= '%' . tab . 'T'
            let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
            let s .= ' ' . tab .':'
            let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

            if bufmodified
                let s .= '[+] '
            endif
        endfor

        let s .= '%#TabLineFill#'
        if (exists("g:tablineclosebutton"))
            let s .= '%=%999XX'
        endif
        return s
    endfunction

    function! ToggleTabline()
        if g:tabline_set == 0
            set tabline=%!Tabline()
            let g:tabline_set = 1
            echo 'tabline toggled on'
        else
            set tabline&
            let g:tabline_set = 0
            echo 'tabline toggled off'
        endif
    endfunction
    """ }}}

    """ Plugin Keybindings {{{
    " Toggle tagbar (definitions, functions etc.)
    if exists('g:plugs["tagbar"]')
        nnoremap <F2> :TagbarToggle<CR>
    endif

    " ALE shortcuts
    if exists('g:plugs["ale"]')
        nnoremap <Leader><Leader>n :ALENextWrap<CR>
        nnoremap <Leader><Leader>p :ALEPreviousWrap<CR>
    endif

    " Commentary shortcuts
    if exists('g:plugs["vim-commentary"]')
        xnoremap <Leader>/ <Plug>Commentary
        nnoremap <Leader>/ <Plug>Commentary
        onoremap <Leader>/ <Plug>Commentary
        nnoremap <Leader>// <Plug>CommentaryLine
        nnoremap <Leader>/u <Plug>Commentary<Plug>Commentary
    endif


    " Gradle shortcuts
    if exists('g:plugs["vim-gradle"]')
        nnoremap <Leader>gr :Gradle run<CR>
        nnoremap <Leader><Leader>r :Gradle run<CR>
    endif
    """ }}}

    """ Plugin settings {{{
    " jedi
    " autocompletion
    let g:jedi#use_tabs_not_buffers = 1
    let g:jedi#popup_on_dot = 0


    " OpenSCAD - Author describes as a hack, running local version with my own
    " edits
    "" Python-like indents (local addition)
    let g:openscad = 1
    let g:openscad_indent = 1
    " PyMode python-mode https://github.com/python-mode/python-mode
    "" No pymode linters - using ALE instead for linting
    " let g:pymode = 0
    " let g:pymode_lint_checkers = []

    " let g:pymode_options_max_line_length = 140
    " let g:pymode_lint_options_pep8 =
    "     \ {'max_line_length': g:pymode_options_max_line_length}

    " ALE
    let g:ale_linters = {'html': ['cspell'], 'python': ['ruff', 'mypy'], 'kotlin': ['languageserver'], 'javascript': ['eslint'], 'json': ['jq', 'jsonlint'], 'sh': ['shell']}
    let g:ale_kotlin_languageserver_executable = $HOME / 'IntelliJIDEA/Projects/kotlin-language-server/server/build/install/server/bin/kotlin-language-server'
    let g:ale_openscad_sca2d_options = '--ignore=W2010,W2011'
    let g:ale_cspell_options = '--language-id html'
    let g:ale_python_mypy_options = '--enable-incomplete-feature=NewGenericSyntax'
    " let g:ale_python_auto_virtualenv = 1

    call ale#Set('openscad_sca2d_options', '')

    " Airline
    if exists('g:airline')
        let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
        let g:airline_powerline_fonts = 1
    endif
    """ }}}

else
    echo 'loading development vimrc from' $HOME/DEV_VIMRC_PREFIX.vimrc
    source $HOME/$DEV_VIMRC_PREFIX.vimrc
endif
