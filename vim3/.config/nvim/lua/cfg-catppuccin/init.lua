require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha, mocha
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
