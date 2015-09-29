se ruler
se nocul
syntax on
se ls=2
se shm=I
colorscheme torte
set guioptions-=T
se guifont=Menlo\ Regular:h15
autocmd BufNewFile,BufRead *.p? compiler perl
au BufRead,BufNewFile  *МодульКоманды* set ft=1c
au BufRead,BufNewFile  *МодульОбъекта* set ft=1c
au BufRead,BufNewFile nginx*.conf set ft=nginx
au BufRead,BufNewFile *.sh.inc set ft=sh
autocmd FileType perl set autoindent|set smartindent
autocmd FileType perl set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
vmap <tab> >gv
vmap <s-tab> <gv
"autocmd FileType perl set autowrite
let perl_include_pod = 1
let perl_extended_vars = 1
"let perl_fold=1
"let perl_fold_blocks=1
"map <F1> :!TERM=xterm-color perldoc -f <cword><Enter>
"map <buffer> <silent> <S-F1> :!perldoc <cword><Enter>
map <F5> :make<Enter>
map <F2> :w<Enter>
imap <F2> <esc>:w<Enter>a
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END
au! BufRead,BufNewFile *.json set filetype=json 
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END 
