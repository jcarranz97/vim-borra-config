set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/vimfiles/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'preservim/tagbar'
Plugin 'vim-syntastic/syntastic'
" Vim Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Git Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"  Enable Syntax
syntax on
let python_highlight_all=1

"  Python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    " \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix|

" Syntastic config 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_flake8_post_args='--ignore=E501,E228'
" let g:syntastic_python_flake8_post_args='--disable=C0301,W0621'
" E501: Line too long (82 &gt; 79 characters) (E501)
" E228: Missing whitespace around modulo operator (E228)
" 
let g:syntastic_python_pylint_post_args="--max-line-length=110" 
" let g:syntastic_check_on_open = 1


" "  Other files indentation
" au BufNewFile,BufRead *.js, *.html, *.css, *.txt
"     \ set tabstop=2 |
"     \ set softtabstop=2 |
"     \ set shiftwidth=2 |
set tabstop=2 
set softtabstop=2 |
set shiftwidth=2 |
set rnu
set nowrap

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ignore some files Nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Other mapping
map <C-p> :TagbarToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-b> :SyntasticCheck<CR>

"  python vim template
" if has("autocmd")
"     augroup templates
"         autocmd BufNewFile *.py 0r ~/vimfiles/templates/skeleton.py
"     augroup END
" endif

"  Remember last line
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Draw line in char 80
highlight ColorColumn ctermbg=gray
set colorcolumn=80

" Vim AirLine Config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
