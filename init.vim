" Fisa-vim-config, a config for both Vim and NeoVim
" http://vim.fisadev.com
" version: 12.0.1

" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal 
" (if you aren't using one of those fonts, you will see funny characters here. 
" Turst me, they look nice when using one of those fonts).
"let fancy_symbols_enabled = 0


set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below 
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy 
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Now the actual plugins:

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Better file browser
Plug 'scrooloose/nerdtree'
" Class/module browser
Plug 'majutsushi/tagbar'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" A couple of nice colorschemes
" Plug 'fisadev/fisa-vim-colorscheme'
Plug 'patstockwell/vim-monokai-tasty'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Async autocompletion
if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
endif
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'
" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'
" Surround
Plug 'tpope/vim-surround'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'
" Better language packs
Plug 'sheerun/vim-polyglot'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Window chooser
Plug 't9md/vim-choosewin'
" Automatically sort python imports
Plug 'fisadev/vim-isort'
" Highlight matching html tags
Plug 'valloric/MatchTagAlways'
" Generate html in a simple way
Plug 'mattn/emmet-vim'
" Git integration
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Yank history navigation
Plug 'vim-scripts/YankRing.vim'
" Linters
Plug 'neomake/neomake'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'
" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

Plug 'Kazark/vim-SimpleSmoothScroll'

"Configure tab labels within Terminal Vim with a very succinct output.
Plug 'mkitt/tabline.vim'

"plugin to highlight todos and fixmes
Plug 'sakshamgupta05/vim-todo-highlight'

" Snippets manager (SnipMate), dependencies, and snippets repo
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'tomtom/tlib_vim'
" UltiSnips is the ultimate solution for snippets in Vim. It has manyfeatures, speed being one of them.
Plug 'SirVer/ultisnips'

"Using the markdown-preview.vim plugin, you can preview Markdown in real-time with a web browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} 

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Autosave session
" first create session :mks <session_file>.vim, after :Obsession <session_file>.vim
Plug 'tpope/vim-obsession'
" Repeat plugins do as surround.vim speeddating.vim unimpaired.vim vim-easyclip vim-radical
Plug 'tpope/vim-repeat'

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

" Code searcher. If you enable it, you should also configure g:hound_base_url 
" and g:hound_port, pointing to your hound instance
" Plug 'mattn/webapi-vim'
" Plug 'jfo/hound.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" Refresh settings
if using_neovim
    nmap <F5> :source ~/.config/nvim/init.vim<CR>
endif

if using_vim
    " A bunch of things that are set by default in neovim, but not in vim
    nmap <F5> :source ~/.vimrc<CR>

    " no vi-compatible
    set nocompatible

    " allow plugins by file type (required for plugins!)
    filetype plugin on
    filetype indent on

    " always show status bar
    set ls=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    " syntax highlight on
    syntax on
    set mouse=a

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end

nno <silent> cou :<c-u>call s:ultisnips_toggle_autotrigger()<cr>

fu s:ultisnips_toggle_autotrigger() abort
    if exists('#UltiSnips_AutoTrigger')
        au! UltiSnips_AutoTrigger
        aug! UltiSnips_AutoTrigger
        echom '[UltiSnips AutoTrigger] OFF'
    else
        augroup UltiSnips_AutoTrigger
            au!
            au InsertCharPre,TextChangedI,TextChangedP * call UltiSnips#TrackChange()
        augroup END
        echom '[UltiSnips AutoTrigger] ON'
    endif
endfu

" MAIN Settings for nvim and vim -------------------
" New moving into panes
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

" resize current buffer by +/- 5 Ctrl+Shift+arrow
nnoremap <S-C-left> :vertical resize -5<CR>
nnoremap <S-C-down> :resize +5<CR>
nnoremap <S-C-up> :resize -5<CR>
nnoremap <S-C-right> :vertical resize +5<CR>

" Run python code
autocmd FileType python nmap <buffer> <leader>r :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

let mapleader=" "
inoremap ;; <Esc>
vnoremap ;; <Esc>

set cursorline
" change current word with copied one
nmap <silent> cp "_cw<C-R>"<Esc>

filetype plugin on
filetype indent on
syntax on

" Insert new line and exit edit mode
nnoremap <leader>o o<Esc>kw
nnoremap <leader>O O<Esc>jw

set mouse=a
" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4


" show line numbers
set nu

" Copy/paste Ctrl+C/Ctrl+V
vmap <C-c> "+y
inoremap <C-V> <C-O>:set paste<CR><C-R><C-R>+<C-O>:set nopaste<CR>



" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    colorscheme vim-monokai-tasty
    hi Normal guibg=NONE ctermbg=NONE
else
    colorscheme delek
endif

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" save as sudo
ca w!! w !sudo tee "%"

set foldenable
set foldmethod=indent
set foldlevel=99

" tab navigation mappings
" next tab
map tt :tabn<CR>
" previous tab
map TT :tabp<CR>
" new tab
map tn :tabnew<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash 

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" tabline ----------------------------
" варианты цветов
" https://misc.flogisoft.com/bash/tip_colors_and_formatting
hi TabLine      ctermfg=Black  ctermbg=LightGrey   cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=LightGrey   cterm=NONE
hi TabLineSel   ctermfg=Black  ctermbg=LightBlue    cterm=NONE

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
map <leader>tt :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" auto close Nerdtree when choose file
let NERDTreeQuitOnOpen=1
" Show hidden files
let NERDTreeShowHidden=1

let g:webdevicons_enable_nerdtree = 1
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.a:extension .'$#'
endfunction

 call NERDTreeHighlightFile('py', 'green', 'none', 'green', '#151515')
 call NERDTreeHighlightFile('db', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
 call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
 call NERDTreeHighlightFile('ini', 'Red', 'none', 'red', '#151515')
 call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
 call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
 call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
 call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>
let g:tlTokenList = [
            \'FIXME', 
            \'TODO', 
            \'XXX',
            \'TOFIX',
            \
            \"BUG", 
            \"ERROR",
            \"WARNING",
            \
            \"IDEA",
            \"TOCHECK",
            \"CHECKED"
            \]
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>,<line2>, '0336')
function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

vnoremap OO :Strikethrough<CR>

augroup my_note
augroup my_bug
augroup my_error
augroup my_plan_todo
augroup my_plan_done

syntax match my_note /NOTE.*/ containedin=.*Comment.* 
syntax match my_bug /\<BUG.*/ containedin=.*Comment.* 
syntax match my_error /ERROR.*/ containedin=.*Comment.* 
syntax match my_plan_todo /\[ ].*/ containedin=.*Comment.* 
syntax match my_plan_done /\[v].*/ containedin=.*Comment.* 

hi my_note ctermfg = 235 ctermbg = 81
hi my_bug term=reverse cterm=underline ctermfg=197
hi my_error term=standout ctermfg=231 ctermbg=197 guifg=#ffffff guibg=#ff005f
hi my_plan_todo  ctermfg=148 ctermbg=238 gui=bold guifg=#A4E400 guibg=#2b2b2b
"hi my_plan_done cterm=italic ctermfg=245 guifg=#8a8a8a
"hi my_plan_done term=bold ctermfg=238 
"hi my_plan_done term=standout ctermfg=245
"hi my_plan_done ctermfg=59
hi my_plan_done cterm=strikethrough ctermfg=59 gui=strikethrough

"set termguicolors
"'NOTE': {
" BUG: some bug in code
"'ERROR': {
" [ ] to do
" [v] done
" [v] d̶o̶n̶e̶ ̶2̶
" WARNING 
" IDEA 
" TOCHECK
" CHECKED
" DONE

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 0

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Deoplete -----------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\   'ignore_case': v:true,
\   'smart_case': v:true,
\})
"complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack 
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!!
let g:fancy_symbols_enabled = 1

if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif


" MarkdownPreview ---------------------
nmap <F6> <Plug>MarkdownPreviewToggle
let g:mkdp_auto_close = 0

" Vim-HighlightedYank     ---------------------
let g:highlightedyank_highlight_duration = 200

" Vim-surround -------------------------
"nmap <leader> s ysiw

" NERD-commenter -----------------------
nmap <leader>cc <plug>NERDCommenterInvert

" UtilSnip -----------------------------
" Trigger configuration. You need to change this to something else than <tab>
" if you use https://github.com/Valloric/YouCompleteMe.
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<C-b>"
 let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" Custom configurations ----------------

" Include user's custom nvim configurations
if using_neovim
    let custom_configs_path = "~/.config/nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif

function! SyntaxAttr()
     let synid = ""
     let guifg = ""
     let guibg = ""
     let gui   = ""

     let id1  = synID(line("."), col("."), 1)
     let tid1 = synIDtrans(id1)

     if synIDattr(id1, "name") != ""
	  let synid = "group: " . synIDattr(id1, "name")
	  if (tid1 != id1)
	       let synid = synid . '->' . synIDattr(tid1, "name")
	  endif
	  let id0 = synID(line("."), col("."), 0)
	  if (synIDattr(id1, "name") != synIDattr(id0, "name"))
	       let synid = synid .  " (" . synIDattr(id0, "name")
	       let tid0 = synIDtrans(id0)
	       if (tid0 != id0)
		    let synid = synid . '->' . synIDattr(tid0, "name")
	       endif
	       let synid = synid . ")"
	  endif
     endif

     " Use the translated id for all the color & attribute lookups; the linked id yields blank values.
     if (synIDattr(tid1, "fg") != "" )
	  let guifg = " guifg=" . synIDattr(tid1, "fg") . "(" . synIDattr(tid1, "fg#") . ")"
     endif
     if (synIDattr(tid1, "bg") != "" )
	  let guibg = " guibg=" . synIDattr(tid1, "bg") . "(" . synIDattr(tid1, "bg#") . ")"
     endif
     if (synIDattr(tid1, "bold"     ))
	  let gui   = gui . ",bold"
     endif
     if (synIDattr(tid1, "italic"   ))
	  let gui   = gui . ",italic"
     endif
     if (synIDattr(tid1, "reverse"  ))
	  let gui   = gui . ",reverse"
     endif
     if (synIDattr(tid1, "inverse"  ))
	  let gui   = gui . ",inverse"
     endif
     if (synIDattr(tid1, "underline"))
	  let gui   = gui . ",underline"
     endif
     if (gui != ""                  )
	  let gui   = substitute(gui, "^,", " gui=", "")
     endif

     echohl MoreMsg
     let message = synid . guifg . guibg . gui
     if message == ""
	  echohl WarningMsg
	  let message = "<no syntax group here>"
     endif
     echo message
     echohl None
endfunction
