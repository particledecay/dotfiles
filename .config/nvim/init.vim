function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction

function! InstallRipGrep(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo install ripgrep
  endif
endfunction

" true colors
if (has("termguicolors"))
  set termguicolors
endif

call plug#begin('~/.local/share/nvim/plugged')
" fuzzy file search
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim', {'do': function('InstallRipGrep')}
" " fzf floating preview pane
Plug 'yuki-ycino/fzf-preview.vim', {'rev': 'release/rpc'}
" enhanced netrw file explorer
Plug 'tpope/vim-vinegar'
" show git diff in the gutter
Plug 'airblade/vim-gitgutter'
" git wrapper
Plug 'tpope/vim-fugitive'
" surround functions
Plug 'machakann/vim-sandwich'
" syntax checking
Plug 'scrooloose/syntastic'
" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" commenting functions
Plug 'scrooloose/nerdcommenter'
" Emmet
Plug 'mattn/emmet-vim', {'for': ['html', 'jsx', 'css']}
" autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" PaleNight color scheme
Plug 'drewtempelmeyer/palenight.vim'
" Markdown preview
Plug 'euclio/vim-markdown-composer', {'do': function('BuildComposer')}
" Carbon screenshots
Plug 'kristijanhusak/vim-carbon-now-sh'
" Go support
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
" asynchronous linting
Plug 'w0rp/ale'
" Delve for Go testing
Plug 'sebdah/vim-delve'
" File-line enables opening a file to a given line
Plug 'bogado/file-line'
" vim-devicons adds icons to plugins that support it
Plug 'ryanoasis/vim-devicons'
" syntax highlighting and formatting for Ansible
Plug 'pearofducks/ansible-vim', {'do': './UltiSnips/generate.sh'}
" vim wrapper for running tests
Plug 'janko/vim-test'
call plug#end()

" detect type of file being edited and set filetype (w/ plugins and indents)
filetype plugin indent on

" defaults
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set relativenumber number   " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set encoding=utf-8          " UTF-8 encoding
set fileformat=unix         " unix-style line formatting
set shell=/usr/bin/fish

" change leader key
let mapleader = ","

" Go files
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" Python files
au FileType py set shiftwidth=4
au FileType py set softtabstop=4
au FileType py set tabstop=4

" Shell env var
let $SHELL = "/usr/bin/fish"

" Python for neovim
let g:python3_host_prog = "/home/joelinux/.pyenv/versions/3.7.3/bin/python"

" [junegunn/fzf] use ctrl+p for fuzzy search
nnoremap <C-p> :FZF<CR>
" [junegunn/fzf] use ctrl+g for ripgrep
nnoremap <C-g> :Rg<CR>
" [junegunn/fzf] top-to-bottom flow
let $FZF_DEFAULT_OPTS="--reverse"
" [yuki-ycino/fzf-preview] open floating window when using fzf
" let g:fzf_layout = { 'window': 'call fzf_preview#window#create_centered_floating_window()' }
" [yuki-ycino/fzf-preview] command for fzf preview
let g:fzf_preview_command = 'bat --color=always -p {-1}'
let g:fzf_preview_floating_window_rate = 0.9

" [scrooloose/nerdcommenter] spaces after comment delimiters
let g:NERDSpaceDelims = 1
" [scrooloose/nerdcommenter] compact syntax for multiline comments
let g:NERDCompactSexyComs = 1
" [scrooloose/nerdcommenter] comment/invert empty lines
let g:NERDCommentEmptyLines = 1
" [scrooloose/nerdcommenter] trim trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" [scrooloose/nerdcommenter] check whether all selected lines are commented already
let g:NERDToggleCheckAllLines = 1
" [scrooloose/nerdcommenter] default to left-align
let g:NERDDefaultAlign = 'left'
" [scrooloose/nerdcommenter] remap align-left comments to ctrl+/
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle

" [vim-airline/vim-airline] set theme
let g:airline_theme='palenight'
" [vim-airline/vim-airline] fix space so powerline symbols show up correctly
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" [vim-airline/vim-airline] enable powerline font symbols
let g:airline_powerline_fonts = 1

" [neoclide/coc.nvim] better display for messages
set cmdheight=2
" [neoclide/coc.nvim] reduce time for diagnostic messages (default is 4000)
set updatetime=300
" [neoclide/coc.nvim] don't give |ins-completion-menu| messages
set shortmess+=c
" [neoclide/coc.nvim] always show signcolumns
set signcolumn=yes
" [neoclide/coc.nvim] remap Tab key to confirm completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" [neoclide/coc.nvim] remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" [neoclide/coc.nvim] use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" [kristijanhusak/vim-carbon-now-sh] use F5 for instant screenshots
vnoremap <F5> :CarbonNowSh<CR>
" [kristijanhusak/vim-carbon-now-sh] set custom theme options
let g:carbon_now_sh_options =
      \ {'bg': 'rgba(123%2C182%2C221%2C0)',
      \  't': 'one-dark',
      \  'wt': 'none',
      \  'l': 'auto',
      \  'ds': 'true',
      \  'dsyoff': '14px',
      \  'dsblur': '15px',
      \  'wc': 'true',
      \  'wa': 'true',
      \  'pv': '44px',
      \  'ph': '44px',
      \  'ln': 'true',
      \  'fm': 'dm',
      \  'fs': '16px',
      \  'lh': '142%2525',
      \  'si': 'false',
      \  'es': '2x',
      \  'wm': 'false'}

" [fatih/vim-go] various highlighting options
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
" [fatih/vim-go] use goimports for auto imports
let g:go_fmt_command = "goimports"
" [fatih/vim-go] use F10 for running tests
au FileType go nmap <F10> :GoTest -short<CR>
" [fatih/vim-go] use F9 for code coverage
au FileType go nmap <F9> :GoCoverageToggle -short<CR>
" [fatih/vim-go] type information in status line
" let g:go_auto_type_info = 1
" [fatih/vim-go] use <leader>gd for go to definition
" au FileType go nmap <leader>gd <Plug>(go-def)
" [fatih/vim-go] automatic JSON tags format
let g:go_addtags_transform = "camelcase"

" [sebdah/vim-delve] set shortcut for setting breakpoint
au FileType go nmap <leader>bp :DlvToggleBreakpoint
" [sebdah/vim-delve] use F12 for running delve
au FileType go nmap <F12> :DlvDebug

" [pearofducks/ansible-vim] highlight extra keywords
let g:ansible_extra_keywords_highlight = 1

" [w0rp/ale] display status information in airline
let g:airline#extensions#ale#enabled = 1
" [w0rp/ale] error/warning signs
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" [drewtempelmeyer/palenight.vim] italics
let g:palenight_terminal_italics=1

" [tpope/vim-fugitive] set keyboard shortcut for git blame
nnoremap <silent> gb :Gblame<CR>

" easier split window navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" copy to clipboard
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y

" paste from clipboard
nnoremap <leader>p  "+p
nnoremap <leader>P  "+P
vnoremap <leader>p  "+p
vnoremap <leader>P  "+P

" split to the right and down by default (feels more natural)
set splitbelow
set splitright

" include line numbers in netrw (why isn't this the default?)
let g:netrw_bufsettings = 'noma nomod rnu nu nobl nowrap ro'

" color scheme
set background=dark
colorscheme palenight

