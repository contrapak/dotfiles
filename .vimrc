
syntax enable
colorscheme murphyme  " Not included in this repo
set ts=4
set sw=4
set so=3
set sbr=↳
set lbr
set si
set nu
set et
set mouse=a  " Make sure to install vim with +xterm_clipboard
set fo-=t  " I can't figure out why +t is being set now.  Infuriating.
set foldlevelstart=99
set foldminlines=3
set wildmode=longest,list
set is
set dy=lastline,uhex
set sb
set spr
set title
set sc
set report=0
set ci
 " Leaving files all over the current directory is messy
set dir=~/tmp
set bdir=~/tmp
 " This is cool
set udf
set udir=~/tmp


 " Consistency is good.
set ve=onemore
noremap <End> $l

" This really shouldn't be necessary.
inoremap # X#

" Most of these were copied from various places on the internet.  I forgot where.

inoremap <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>


let treeExplVertical = 1
let treeExplWinSize = 24

let NERDChristmasTree = 0
let NERDTreeWinSize = 24
let NERDTreeIgnore = ['\.hi$', '\.o$', '\.exe']

" Add highlighting for function definition in C++
autocmd BufEnter *.cpp set syntax=mycpp
autocmd BufEnter *.c set syntax=mycpp
autocmd BufEnter *.h set syntax=mycpp
autocmd BufEnter *.java set syntax=mycpp
autocmd BufEnter *.p6 set syntax=
autocmd BufEnter *.cpp.epl set syntax=mycpp
autocmd BufEnter *.hs set syntax=myhs
autocmd BufEnter *.ohs set syntax=myhs

autocmd Syntax ruby set sw=2
autocmd Syntax ruby set ts=2

function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') > 1
    return '0'  " if not at start, go to start
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction
noremap <expr> <silent> <Home> SmartHome()
imap <silent> <Home> <C-O><Home>

 " From the help file
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" Bring attention to too-long lines (is.gd/IBV2013)
highlight ColorColumn ctermbg=darkgrey
call matchadd('ColorColumn', '\%81v', 100)

" Show tabs, trailing whitespace, NBSPs (is.gd/IBV2013)
set listchars=tab:·\ ,trail:·,nbsp:·
set list

" Make this easier (is.gd/IBV2013)
nnoremap ; :
