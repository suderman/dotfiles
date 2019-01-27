" Launch vimrc with ,v
nmap <leader>v :EditVimRC<CR>
command! EditVimRC call s:EditVimRC()
function! s:EditVimRC()
  let l:title = expand("%:t")
  if (l:title == 'init.vim')
    :edit ~/.vim/packages.vim
  else
    :edit ~/.vim/init.vim
  endif
endfunction
