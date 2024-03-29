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
Plugin 'dense-analysis/ale'
" Vim Plugins
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Git Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'zivyangll/git-blame.vim'
Plugin 'f-person/git-blame.nvim'
" Git/Search
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
" Vim Colors
Plugin 'catppuccin/nvim'
Plugin 'arcticicestudio/nord-vim'

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

"  C Code indentation
au BufNewFile,BufRead *.c,*.cpp
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix|

" Syntastic config 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
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
map <C-i> :bnext<CR>
map <C-u> :bprevious<CR>
nmap <F2> :GF?<CR>
nmap <F3> :GFiles<CR>
nmap <F4> :Ag<CR>
nmap <F5> :Ar<CR>


"  python vim template
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
    augroup END
endif

"  Remember last line
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Draw line in char 80
highlight ColorColumn ctermbg=gray
set colorcolumn=80

" VIm Colors - Config
set background=dark
colorscheme catppuccin
colorscheme nord

" Vim AirLine Config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" git-blame config
let g:gitblame_message_template = ' <author> • <sha> • <date> • <summary>'
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python3'

" Add ros humbe libraries to path
if isdirectory("/opt/ros/humble/include")
    set path+=/opt/ros/humble/include
    echo $path
endif

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" C/C++ ROS 2 Configuration
let g:ale_cpp_cc_options = '-std=c++17 -Wall -I/opt/ros/humble/include -DSOME=\"define\"'

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}
