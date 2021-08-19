call plug#begin('~/.vim/plugged')
Plug '~/.vim/custom-plugs/colemak'
call plug#end()

filetype plugin indent on
syntax on
set relativenumber
set omnifunc=syntaxcomplete#Complete

" Alacritty
set ttymouse=sgr

