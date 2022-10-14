vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use "folke/lua-dev.nvim"
    use 'wbthomason/packer.nvim'
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "mfussenegger/nvim-jdtls" -- java
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            'simrat39/rust-tools.nvim',
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
    use 'renerocksai/telekasten.nvim'
    use 'renerocksai/calendar-vim'
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

    use 'kdheepak/lazygit.nvim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-media-files.nvim'
    }
}

use 'norcalli/nvim-colorizer.lua'
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


use {
    "NTBBloodbath/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
}
use 'nvim-treesitter/nvim-treesitter'

use "icedman/nvim-textmate"
use 'nvim-treesitter/nvim-treesitter-context'
-- Plugins can also depend on rocks from luarocks.org:
use {
    '~/.dotfiles/vim3/.config/nvim/lua/jira',
    rocks= {'http', 'lunajson', 'lua-resty-http'}
}

use {
    '~/.dotfiles/vim3/.config/nvim/lua/jbehave',
    '~/.dotfiles/vim3/.config/nvim/lua/kube',
    '~/.dotfiles/vim3/.config/nvim/lua/helm',
    '~/.dotfiles/vim3/.config/nvim/lua/java-dependencies',
    '~/.dotfiles/vim3/.config/nvim/lua/cyberpunk',
    '~/.dotfiles/vim3/.config/nvim/lua/youtube',
}

use 'f-person/git-blame.nvim'

use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' } }
}

use 'MunifTanjim/nui.nvim'


use  {
    'kaicataldo/material.vim'
}

use 'rakr/vim-one'
use 'dylanaraps/wal.vim'

use 'folke/tokyonight.nvim'
use 'Mofiqul/vscode.nvim'


use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
})

use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

end)


