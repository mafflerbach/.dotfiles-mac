vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "mfussenegger/nvim-jdtls" -- java
    use 'folke/tokyonight.nvim'
    use { 
        "rcarriga/nvim-dap-ui", 
        requires = {
            "mfussenegger/nvim-dap",
            'theHamsta/nvim-dap-virtual-text'
        } 
    }
    use 'psliwka/vim-smoothie'
    use 'camspiers/animate.vim'
    use 'chrisbra/csv.vim'
    use 'tpope/vim-dispatch'
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            'hrsh7th/nvim-compe',
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",

            "onsails/lspkind-nvim",
            -- "hrsh7th/cmp-nvim-lua", -- neovim lua autocompletion,
            "f3fora/cmp-spell"
        }
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup { diagnostics = { enable = true } } end
    }

    use 'jremmen/vim-ripgrep'

    use {
        'yamatsum/nvim-nonicons',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use 'rcarriga/nvim-notify'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'simrat39/symbols-outline.nvim'

    use 'junegunn/vim-easy-align'

    use 'preservim/nerdcommenter'

    use  {
        'kaicataldo/material.vim'
    }
    use 'kdheepak/lazygit.nvim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

    --    use 'nvim-telescope/telescope-dap.nvim'

    use 'mogelbrod/vim-jsonpath'

    use {
        'tpope/vim-dadbod',
        requires = {
            'kristijanhusak/vim-dadbod-ui',
            'kristijanhusak/vim-dadbod-completion'
        }
    }

    use 'vim-pandoc/vim-pandoc'
    use 'vim-pandoc/vim-pandoc-syntax'

    use {
        'benmills/vimux',
        requires = {
            'christoomey/vim-tmux-navigator'
        }
    }

    use 'vim-test/vim-test'
    --   use 'NLKNguyen/papercolor-theme'

    use 'rakr/vim-one'
    use 'dylanaraps/wal.vim'

    use {
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    }
    --  use 'Mofiqul/vscode.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    -- use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

    -- Plugins can also depend on rocks from luarocks.org:
    use {
        '~/.dotfiles/vim3/.config/nvim/lua/jira',
        rocks= {'http', 'lunajson'}

    }
end)



-- require('nvim-dap-ui')
