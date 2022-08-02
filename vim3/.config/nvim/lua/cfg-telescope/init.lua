
require('telescope').setup{
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { height = 0.95 },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}


-- require('telescope').load_extension('dap')
require('telescope').load_extension('fzf')
