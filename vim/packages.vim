" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

if !exists('*minpac#init')
  finish
endif

" Plugin manager
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})


" -- All the plugins --

" Colorscheme
call minpac#add('morhetz/gruvbox')
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('flazz/vim-colorschemes')

" Status line
call minpac#add('itchyny/lightline.vim')

" Quickly switch between buffers
call minpac#add('jlanzarotta/bufexplorer')

" Nerd Tree file management
call minpac#add('scrooloose/nerdtree')
call minpac#add('taiansu/nerdtree-ag')
call minpac#add('Xuyuanp/nerdtree-git-plugin')

" Fuzzy Finder
call minpac#add('junegunn/fzf.vim')

" Vim/Tmux integration
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('roxma/vim-tmux-clipboard')

" Git
call minpac#add('tpope/vim-git')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('gregsexton/gitv')
call minpac#add('airblade/vim-gitgutter')

" Tim Pope's good stuff
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-obsession')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-repeat')

" Ruby/Rails 
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('tpope/vim-bundler')

" Auto-close brackets, quotes, etc
call minpac#add('Raimondi/delimitMate')

" Command line mode mappings
call minpac#add('vim-utils/vim-husk')

" Find and Replace
call minpac#add('brooth/far.vim')

" Silver Searcher
call minpac#add('rking/ag.vim')

" Grep
call minpac#add('mhinz/vim-grepper')

" Undo tool
call minpac#add('sjl/gundo.vim')

" Easier cursor movement
call minpac#add('justinmk/vim-sneak')
call minpac#add('bkad/CamelCaseMotion')
call minpac#add('henrik/vim-indexed-search')

" Code commenter
call minpac#add('tomtom/tcomment_vim')

" Auto cd to project root
call minpac#add('airblade/vim-rooter')

" :Align
call minpac#add('tsaleh/vim-align')

" Syntax errors
call minpac#add('vim-syntastic/syntastic')

" Syntax colors
call minpac#add('othree/html5.vim')
call minpac#add('blueyed/smarty.vim')
call minpac#add('lumiliet/vim-twig')
call minpac#add('vim-scripts/jade.vim')
call minpac#add('kchmck/vim-coffee-script')
call minpac#add('lchi/vim-toffee')
call minpac#add('vim-scripts/jQuery')
call minpac#add('hail2u/vim-css3-syntax')
call minpac#add('groenewege/vim-less')
call minpac#add('ekalinin/Dockerfile.vim')
call minpac#add('bwangel23/nginx-vim-syntax')
call minpac#add('vim-scripts/openvpn')
call minpac#add('othree/yajs.vim')
call minpac#add('othree/javascript-libraries-syntax.vim')
call minpac#add('mxw/vim-jsx')
if has('Python')
  call minpac#add('valloric/MatchTagAlways')
endif
