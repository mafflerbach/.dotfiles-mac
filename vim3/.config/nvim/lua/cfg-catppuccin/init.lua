require("catppuccin").setup({
    flavour = "chai", -- latte, frappe, macchiato, mocha, chai
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        treesitter = true,
        markdown = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    }

})
