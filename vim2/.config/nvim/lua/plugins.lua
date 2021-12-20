


-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'junegunn/fzf.vim'
    use 'junegunn/vim-easy-align'

    use 'preservim/nerdcommenter'
    use 'elkowar/yuck.vim'


    use  {
        'kaicataldo/material.vim'
    }
    use 'dylanaraps/wal.vim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use 'mogelbrod/vim-jsonpath'
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
    use 'tpope/vim-projectionist'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup { diagnostics = { enable = true } } end
    }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
            'mfussenegger/nvim-jdtls',
            'hrsh7th/nvim-compe',
            'simrat39/rust-tools.nvim',
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'hrsh7th/vim-vsnip',
            'hrsh7th/vim-vsnip-integ',
            'RishabhRD/popfix',
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
            'RishabhRD/nvim-lsputils',
            "ray-x/lsp_signature.nvim"
        }
    }

    use 'szw/vim-maximizer'
    use 'jremmen/vim-ripgrep'

    use {
        'yamatsum/nvim-nonicons',
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use 'rcarriga/nvim-notify'
    use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
    }

    use "ellisonleao/glow.nvim"

    use 'psliwka/vim-smoothie'
    use 'camspiers/animate.vim'


    use 'vim-test/vim-test'
    use 'vim-pandoc/vim-pandoc'
    use 'vim-pandoc/vim-pandoc-syntax'

use 'junegunn/goyo.vim'
use {
  "NTBBloodbath/rest.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    require("rest-nvim").setup({
      -- Open request results in a horizontal split
      result_split_horizontal = true,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
    })
  end
}


end)

