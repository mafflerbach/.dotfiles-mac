


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

    use 'benmills/vimux'
    use 'christoomey/vim-tmux-navigator'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'rafamadriz/friendly-snippets'
    use 'tpope/vim-fugitive'
    use 'kyazdani42/nvim-tree.lua'
    use 'mfussenegger/nvim-jdtls'
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'RishabhRD/popfix'
    use 'mfussenegger/nvim-dap'
    use 'RishabhRD/nvim-lsputils'
    use "ray-x/lsp_signature.nvim"
    use 'jremmen/vim-ripgrep'
    use 'rcarriga/nvim-dap-ui'
    use 'szw/vim-maximizer'

    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() require'my_statusline' end,
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'yamatsum/nvim-nonicons',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
end)

