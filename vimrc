set nocompatible

""======= plugins
call plug#begin('~/.vim/plugged')

"fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()
""-----------------

"asdfasdfasdf
execute pathogen#infect()
"filetype plugin indent on

"=== The ":syntax enable" command will keep your current color settings.  This
"allows using ":highlight" commands to set your preferred colors before or
"after using this command.  If you want Vim to overrule your settings with the
"defaults, use: >
"    :syntax on
if !exists("g:syntax_on")
    syntax enable
endif
""---

set tabstop=2 "Number of spaces that a <Tab> in the file counts for
set shiftwidth=2 "Number of spaces to use for each step of (auto)indent
set softtabstop=2 "Number of spaces that a <Tab> counts for while performing editing operations
set expandtab "tabs expanded to spaces
set smartindent "Do smart autoindenting when starting a new line
set autoindent "Copy indent from current line when starting a new line

set showmatch "When a bracket is inserted, briefly jump to the matching one
set number "show line numbers
set scrolloff=5 "Minimal number of screen lines to keep above and below the cursor.

""=== Show tab characters, trailing whitespace
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list "Show tabs as CTRL-I is displayed, display $ after end of line
""---

""=== Solarized stuff
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized
""---

set hls "highlight search options
set incsearch "While typing show incremental search
set ic "default to case-insensitive search
set smartcase "allow case-sensitive search if there is one uppercase

set cursorline "highlight current line
hi CursorLine ctermbg=NONE cterm=underline "no color, just underline
set wildmode=longest,list "on tab filename complete, first tab produces longest. Second tab produces list.


"Asdfasdf

set backspace=indent,eol,start "allow backspacing over indent, eol, start
set laststatus=2 " Set status line as second-to-last line
set statusline=%F%m%r%w\ %=\ [%l,%c]\ \ \ %p%%


""""remapping the keys in vim----------------------------
"" Remap jk while in insert mode to ESC
""inoremap jk <ESC>
"" Remap kj while in insert mode to ESC
"inoremap kj <ESC>


" Remap window switching
nnoremap op <C-w><Right>
nnoremap po <C-w><Left>
nnoremap qw <C-w><Left>
nnoremap wq <C-w><Left>
nnoremap wee <C-W><=>
" Improved up/down scrolling on wrapped lines
nnoremap j gj
nnoremap k gk
"nnoremap <up> gk
"nnoremap <down> gj
imap <up> <c-o>gk
imap <down> <c-o>gj

"""auto reload vim----------------------
augroup AutoReloadVimRC
    au!
    " automatically reload vimrc when it's saved
    au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

set autochdir " Automatically change current working directory to most recent file



"""enable ctrlp----------------------
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"let g:ctrlp_working_path_mode = 'ra'

"""use ag serach instead of ack when available-------------------
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"""ctags------------------------
set tags=tags;/
set tags+=~/.tags/scala/tags
set tags+=~/.tags/finagle/tags
set tags+=~/.tags/finch/tags
set tags+=~/.tags/akka/tags
set tags+=~/.tags/playframework/tags


"""neocomplete----------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



" fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

