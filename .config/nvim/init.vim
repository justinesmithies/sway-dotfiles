" init.vim - Justine Smithies

" vim-plug autoconfig if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | nested source $MYVIMRC
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" startup for vim-plug
call plug#begin("~/.config/nvim/plugged")

" Make sure you use single quotes

" vim-gruvbox Plugin
Plug 'morhetz/gruvbox'

" coc-nvim Plugin
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-polyglot Plugin
Plug 'sheerun/vim-polyglot'

" vim-startify Plugin
Plug 'mhinz/vim-startify'

" Tagbar Plugin
Plug 'preservim/tagbar'

" NERDTree Plugin
Plug 'preservim/nerdtree'

" vim-devicons Plugin
Plug 'ryanoasis/vim-devicons'

" vim-airline Plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" IndentLine Plugin
Plug 'Yggdroot/indentLine'

" vim-hexokinase Plugin
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" ALE Plugin
Plug 'dense-analysis/ale'

" vim-commentary Plugin
Plug 'tpope/vim-commentary'

" UndoTree Plugin
Plug 'mbbill/undotree'

" winresizer Plugin
Plug 'simeji/winresizer'

" FZF Plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic
set encoding=utf-8                                  " Set encoding to utf-8
set number                                          " Show line numbers on the sidebar
nnoremap <F4> :set number!<CR>                      " Toggle line numbers
set clipboard=unnamedplus                           " Copy paste between vim and everything else
set nocompatible                                    " Use Vim defaults (much better!)
set hlsearch                                        " Highlight search results
set ignorecase                                      " Search ignoring case
set smartcase                                       " Do not ignore case if the search patter has uppercase
set incsearch                                       " Incremental search
set splitbelow                                      " Split below current window
set splitright                                      " Split window to the right

" guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
    " define a path to store persistent_undo files.
    let target_path = expand('~/.config/nvim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif

    " point Vim to the defined undo directory.
    let &undodir = target_path

    " finally, enable undo persistence.
    set undofile
endif

" number of undo saved
set undolevels=10000 " How many undos
set undoreload=10000 " number of lines to save for undo

" Colours
set termguicolors                                   " Enable 24-bit colors on terminal
syntax enable                                       " Enable syntax highlighting
set background=dark                                 " Use colors that suit a dark background
colorscheme gruvbox                                 " Change colorscheme
hi Normal guibg=NONE ctermbg=NONE                   " Make sure background stays transparent

" Search
set hlsearch                                        " Enables search result highlighting

set wildmode=longest,list,full
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]

let g:startify_bookmarks = [
            \ { 'b': '~/.bashrc' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'p': '~/.config/qutebrowser/config.py' },
            \ { 'c': '~/.config/qtile/config.py' },
            \ { 'a': '~/.config/qtile/autostart.sh' },
            \ ]

" Close NERDTRee before saving session
let g:startify_session_before_save = [ 'silent! tabdo NERDTreeClose' ]
" Save session on exit to session.vim
let g:startify_session_persistence = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC extensions to be auto installed
let g:coc_node_args = ['--max-old-space-size=8192']
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-phpls',
    \ 'coc-sh',
    \ 'coc-pyright',
    \]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

highlight ALEError guibg=#434343 guisp=White
highlight ALEInfo guibg=#434343 guisp=White
highlight ALEWarning guibg=#434343 guisp=White
highlight ALEErrorLine guibg=#434343 gui=bold
highlight ALEInfoLine guibg=#434343 gui=bold
highlight ALEWarningLine guibg=#434343 gui=bold

" Use system flake8
"let g:ale_python_flake8_executable = '/usr/bin/flake8'
let g:ale_linters = {
\   'python': ['flake8'],
\   'sh': ['shellcheck'],
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hexokinase
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim default
let g:Hexokinase_highlighters = [ 'virtual' ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show hidden files on NERDTree      
let g:airline#extensions#tabline#enabled = 1
" Show hidden files on NERDTree
let g:airline_theme='powerlineish'
" Use powerline fonts for airline
let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show hidden files on NERDTree
let NERDTreeShowHidden=1

" Toggle NERDTree
:nnoremap <F7> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only split
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagBar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle TagBar
:nnoremap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IndentLines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable IndentLines by default
let g:indentLine_enabled = 0

" Toggle IndentLines
:noremap <F5> :IndentLinesToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-mundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F6> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 1
let g:undotree_SplitWidth = 45
let g:undotree_DiffpanelHeight = 10
let g:undotree_SetFocusWhenToggle = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Get both NERDTree and Startify working at startup if no args passed
autocmd StdinReadPre * let g:isReadingFromStdin = 1
autocmd VimEnter * if !argc() && !exists('g:isReadingFromStdin') | Startify | endif
" auto source when writing to init.vm alternatively you can run :source ~/.config/nvim/init.vim
au! BufWritePost ~/.config/nvim/init.vim source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Silent version of the super user edit, sudo tee trick.
cnoremap W!! execute 'silent! write !sudo /usr/bin/tee "%" >/dev/null' <bar> edit!
" Talkative version of the super user edit, sudo tee trick.
cmap w!! w !sudo /usr/bin/tee >/dev/null "%"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a terminal in nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>vt :vsplit term://bash<CR>
map <Leader>ht :split term://bash<CR>
