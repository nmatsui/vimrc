scriptencoding utf-8
colorscheme elflord

" NeoBundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'kana/vim-submode'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"display
syntax on
set number
set ruler
set showcmd

"indent
set autoindent
set cindent
set tabstop=2
set shiftwidth=2
set expandtab

"mouse
set mouse=a

"cursor
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

"split window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's.', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's,', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '.', '<C-w>+')
call submode#map('bufmove', 'n', '', ',', '<C-w>-')

"neocomplete
if neobundle#is_installed('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'
elseif neobundle#is_installed('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns._ = '\h\w*'
endif

"neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_or_jump)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"unite
"let g:unite_enable_start_insert = 1
nnoremap <silent> ff :<C-u>Unite -no-split -buffer-name=files file file/new<CR>
nnoremap <silent> fb :<C-u>Unite -no-split buffer<CR>
nnoremap <silent> fm :<C-u>Unite -no-split file_mru file/new<CR>
nnoremap <silent> fd :<C-u>UniteWithBufferDir -no-split file file/new<CR>
nnoremap <silent> fa :<C-u>Unite -no-split file file/new file_mru buffer bookmark<CR>

au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> <Plug>(unite_exit)
au FileType unite set nopaste

"vimshell
let g:vimshell_prompt_expr = 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\(\f\|\\.\)\+> '
nnoremap <silent> sh  :VimShell<CR>

"simple-javascript-indenter
let g:SimpleJSIndenter_BriefMode = 1
let g:SimpleJSIndenter_CaseIndentLevel = -1

"vim-coffee-script
autocmd BufWritePost *.coffee silent make!

"for Markdown
au BufRead,BufNewFile *.md set filetype=markdown

"for fcitx
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()

"for statusline
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified'] ],
  \   'right': [ ['lineinfo'], ['char_counter'], ['fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'mode': 'MyMode'
  \ },
  \ 'component': {
  \   'char_counter': '%{b:char_counter_count}'
  \ }
\ }
function! MyMode()
  return &ft == 'unite' ? 'Unite' :
       \ &ft == 'vimfiler' ? 'VimFiler' :
       \ &ft == 'vimshell' ? 'VimShell' :
       \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
augroup char_counter
  autocmd!
  autocmd BufCreate,BufEnter * call s:char_counter_initialize()
  autocmd BufNew,BufEnter,BufWrite,InsertLeave * call s:char_counter_update()
augroup END
function! s:char_counter_initialize()
  if !exists('b:char_counter_count')
    let b:char_counter_count = 0
  endif
endfunction
function! s:char_counter_update()
  let b:char_counter_count = s:char_counter()
endfunction
function! s:char_counter()
  let result = 0
  for linenum in range(0, line('$'))
    let line = getline(linenum)
    let result += strlen(substitute(line, '.', 'x', 'g'))
  endfor
  return result
endfunction
if !exists('b:char_counter_count')
  let b:char_counter_count = 0
endif
set stl+=\ %{b:char_counter_count}
