


-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'junegunn/fzf.vim'
    use 'junegunn/vim-easy-align'

    use  'dylanaraps/wal.vim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }


    use 'tyru/open-browser.vim'

    use {
        'tpope/vim-dadbod',
        requires = {
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion'
        }
    }


    use {
        'benmills/vimux',
        requires = {
            'christoomey/vim-tmux-navigator'
        }
    }


    use  'tpope/vim-dispatch'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'rafamadriz/friendly-snippets'
    use 'tpope/vim-fugitive'
    use 'kyazdani42/nvim-tree.lua'


    use {
        'neovim/nvim-lspconfig',
        requires = {
            'kabouzeid/nvim-lspinstall',
            'mfussenegger/nvim-jdtls',
            'hrsh7th/nvim-compe',
            'hrsh7th/vim-vsnip',
            'hrsh7th/vim-vsnip-integ',
            'RishabhRD/popfix',
            'mfussenegger/nvim-dap',
            'RishabhRD/nvim-lsputils',
            "ray-x/lsp_signature.nvim"
        }
    }

    use 'rcarriga/nvim-dap-ui'
    use 'szw/vim-maximizer'
    use 'jremmen/vim-ripgrep'

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'yamatsum/nvim-nonicons',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
end)

