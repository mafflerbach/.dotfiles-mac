if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/nvim/plugged')

" color scheme
Plug 'dylanaraps/wal.vim'

" better dir navigator
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" better dir navigator
Plug 'scrooloose/nerdtree'

" git status symbols in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'

" icons in nerdtree
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" http client
Plug 'diepm/vim-rest-console' 

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" faster grep
Plug 'jremmen/vim-ripgrep'

" aligning everything
Plug 'junegunn/vim-easy-align'

" better code commenting
Plug 'scrooloose/nerdcommenter'

" git integration
Plug 'tpope/vim-fugitive'
" Git status in file per line
Plug 'mhinz/vim-signify'

" Outline code
Plug 'majutsushi/tagbar'

" smooth scrooling"
Plug 'psliwka/vim-smoothie'
Plug 'camspiers/animate.vim'

" vim tmux integration 
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" debugger
Plug 'puremourning/vimspector'

" async calls 
Plug 'tpope/vim-dispatch'

" more intuitivfe find and replace in the whole project
" Plug 'brooth/far.vim'

"Database client 
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" better java syntax highlighting
Plug 'mafflerbach/java-syntax.vim'

Plug 'tfnico/vim-gradle'

" http client
Plug 'diepm/vim-rest-console' 

Plug 'vimwiki/vimwiki'

" fuzzy search integration
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Markdown preview in browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" log highlighting
Plug 'mtdl9/vim-log-highlighting'

" Coc vim implements language server features for different languages
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf'

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'tpope/vim-surround'
Plug 'mogelbrod/vim-jsonpath'

Plug 'uzxmx/vim-widgets'

" Arduino build and flash support
Plug 'stevearc/vim-arduino'

"Plug 'mfussenegger/nvim-jdtls'
"Plug 'hrsh7th/nvim-compe'
"Plug 'hrsh7th/vim-vsnip'
"Plug 'neovim/nvim-lspconfig'
call plug#end()

" 'coc-java', 'coc-java-debug',
" Coc plugins
 let g:coc_global_extensions = ['coc-json', 'coc-css', 'coc-docker', 'coc-go', 'coc-gocode', 'coc-html',  'coc-json', 'coc-markdownlint', 'coc-marketplace', 'coc-phpactor', 'coc-post', 'coc-python', 'coc-rls', 'coc-rust-analyzer', 'coc-sh' , 'coc-sql', 'coc-tsserver', 'coc-vimlsp',  'coc-xml', 'coc-yaml', 'coc-explorer']
