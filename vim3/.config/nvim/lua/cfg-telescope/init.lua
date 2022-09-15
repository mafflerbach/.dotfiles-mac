
require('telescope').setup{
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = { height = 0.95 },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        }
    }
}


-- require('telescope').load_extension('dap')
require('telescope').load_extension('fzf')
require('telescope').load_extension('telescope_jbehave')
require('telescope').load_extension('conventional_commits')
require('telescope').load_extension('media_files')
