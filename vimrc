" :so ~/.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set shell=zsh
autocmd BufWritePre * :%s/\s\+$//e "strip trailing white space
set nrformats=hex
set noerrorbells
set encoding=utf-8
set autowrite
set laststatus=2
set number                                 " show line numbers
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                        " Store lots of :cmdline history
set showcmd                             " Show incomplete cmds down the bottom
set showmode                           " Show current mode down the bottom
set gcr=a:blinkon0                     " Disable cursor blink
set visualbell                              " No sounds
set autoread                              " Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

set clipboard=unnamed
" Automatically change the current directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
set wildmenu
set wildmode=full
let $PATH = "/usr/local/bin".$PATH


" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb


" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif


" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       " Don't wrap lines
set linebreak    " Wrap lines at convenient points

"work great when you are reading/writing in text format file
" set wrap
" set showbreak=>\


" ================ Folds ============================

set foldmethod=indent   " fold based on indent
set foldnestmax=3         " deepest fold is 3 levels
set nofoldenable            " dont fold by default


" ================ Scrolling ========================

set scrolloff=8               " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1


" ================ Search ===========================

set incsearch               " Find the next match as we type the search
set hlsearch                 " Highlight searches by default
set ignorecase             " Ignore case when searching...
set smartcase              " ...unless we type a capital


" ================ Display Settings ====================
set t_Co=256
set guifont=Meslo\ LG\ M\ DZ:h20
colorscheme molokai
set list
set splitright
set splitbelow
set showmatch

let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile
function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction
set statusline=win:%{WindowNumber()}

"+++ Lines & Columns +++
" highlight current line
set cursorline
set relativenumber


"+++ Pathogen +++
execute pathogen#infect()


"+++ Spelling +++
set spelllang=en_us
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell


"+++ Keymaps +++
map! jj <esc>
nmap oo o<esc>k
nmap OO O<esc>j
map // :TComment<cr>
nmap /" cs'"
nmap /' cs"'
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv
nmap <C-h> gT
nmap <C-l> gt


"+++ Search +++
" map a specific key or shortcut to open NERDTree
map <leader>k :NERDTreeToggle<enter>
set grepprg=ag\ --nogroup\ --nocolor
let NERDTreeIgnore=['\.vim$', '\~$', '^Godeps$', '\.git$', 'node_modules$']


nnoremap <leader>a :Ack

"+++ CtrlP +++
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_max_height = 10
let g:ctrlp_mruf_max = 250
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|build)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
  \ }

func! MyPrtMappings()
  let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
  \ }
endfunc

func! MyCtrlPTag()
let g:ctrlp_prompt_mappings = {
\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
\ 'AcceptSelection("t")': ['<c-t>'],
\ }
CtrlPBufTag
endfunc

let g:ctrlp_buffer_func = { 'exit': 'MyPrtMappings' }
com! MyCtrlPTag call MyCtrlPTag()

let g:ctrlp_buftag_types = {
\ 'go'         : '--language-force=go --golang-types=ftv',
\ 'coffee'     : '--language-force=coffee --coffee-types=cmfvf',
\ 'markdown'   : '--language-force=markdown --markdown-types=hik',
\ 'objc'       : '--language-force=objc --objc-types=mpci',
\ 'rc'         : '--language-force=rust --rust-types=fTm'
\ }
let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_by_filename = 1
let g:ctrlp_by_filename = 0
let g:ctrlp_match_window = 'top,order:ttb'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_open_new_file = 'et'

map <leader>p :ClearCtrlPCache<cr>:CtrlP<enter>


"+++ Syntastic +++
"https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"+++ fzf +++
" https://github.com/junegunn/fzf
set rtp+=~/.fzf


"+++ Indentline-vim +++
" http://vimawesome.com/plugin/indentline-vim
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

"+++ Unite +++
let g:unite_source_history_yank_enable = 1
map <leader>y :<C-u>Unite history/yank<cr>

"+++ UltiSnips +++
let g:UltiSnipsExpandTrigger="<c-]>"
let g:UltiSnipsEditSplit="vertical"

" +++ vim-airline +++
" let g:airline#extensions#tabline#enabled = 1

" +++ omni-completion +++
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"+++ Go +++
let $GO_ENV="test"
autocmd FileType go map <leader>go :w<CR>:!go run %<enter>
" autocmd FileType go map <leader>r :w<CR>:!go test ./...<enter>
autocmd FileType go map <leader>r :w<CR>:!gode test ./...<enter>
autocmd FileType go map <leader>rt :w<CR>:!./test.sh<enter>
autocmd FileType go map <leader>b :w<CR>:!./bench.sh<enter>
" autocmd FileType go map <leader>l :w<CR>:GoLint<enter>
autocmd FileType go map <leader>l :w<CR>:!gometalinter<enter>
autocmd FileType xml map <leader>l :w<CR>:silent %!xmllint --encode UTF-8 --format -<enter>
autocmd FileType go map <leader>v :w<CR>:GoVet<enter>
autocmd FileType go map <leader>mt :TestFile<enter>
autocmd FileType go map <leader>mm :TestLast<enter>
autocmd FileType go map <leader>mtl :TestNearest<enter>
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let $GOPATH = "/Users/mattma/go"
let g:go_bin_path = "/usr/local/go/bin"
let g:go_fmt_command = "goimports"
" autocmd BufWritePost *.go silent :GoImports

"+++ git +++
map <leader>gst :!git status<enter>
map <leader>ga :!git add -A .<enter>
map <leader>gp :!git push<enter>
map <leader>gca :!git commit -a -v<enter>
map <leader>gcb :!git checkout -bv<enter>

"+++ JavaScript/CoffeeScript +++
autocmd FileType js map <leader>js :!node %<enter>
autocmd FileType coffee map <leader>cs :!coffee %<enter>
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
au BufWrite *.js :Autoformat

"+++ CSS/SCSS +++
au BufWrite *.css :Autoformat
au BufWrite *.scss :Autoformat

"+++ HTML +++
" au BufWrite *.html :Autoformat

"+++ Markdown +++
let g:markdown_fenced_languages=['ruby', 'erb=eruby', 'javascript', 'html', 'sh', 'coffeescript', 'go']
autocmd FileType markdown map <leader>md :!mark %<enter><enter>

"+++ Closetag +++
autocmd FileType html,eruby,erb,tmpl let b:closetag_html_style=1

"+++ Tagbar +++
map <leader>t :TagbarToggle<cr>

"+++ Tmux +++
" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)
" function! WrapForTmux(s)
"   if !exists('$TMUX')
"     return a:s
"   endif
"
"   let tmux_start = "\<Esc>Ptmux;"
"   let tmux_end = "\<Esc>\\"
"
"   return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
" endfunction
"
" let &t_SI .= WrapForTmux("\<Esc>[?2004h")
" let &t_EI .= WrapForTmux("\<Esc>[?2004l")
"
" function! XTermPasteBegin()
"   set pastetoggle=<Esc>[201~
"   set paste
"   return ""
" endfunction
"
" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"
" if exists('$TMUX')
"   " set term=screen-256color
" endif

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
