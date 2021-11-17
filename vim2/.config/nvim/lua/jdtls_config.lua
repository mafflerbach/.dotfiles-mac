local M = {}
function M.setup()
    vim.cmd[[set noexpandtab]]
    local bundles = {
        vim.fn.glob("/home/maren/Downloads/java-debugger/com.microsoft.java.debug.plugin-0.32.0.jar"),
    }

    local on_attach = function()
        require("jdtls").setup_dap({ hotcodereplace = 'auto' })
    end
    local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    require('jdtls').start_or_attach({
        on_attach = on_attach,
        cmd = {'java-lsp.sh', workspace_dir},  
        init_options = { bundles = bundles },
    })
    -- Utility servers

    local jdtls_ui = require'jdtls.ui'
    function jdtls_ui.pick_one_async(items, _, _, cb)
        require'lsputil.codeAction'.code_action_handler(nil, nil, items, nil, nil, nil, cb)
    end
    vim.cmd[[command! -buffer JdtCompile lua require('jdtls').compile()]]
    vim.cmd[[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]]
    vim.cmd[[command! -buffer JdtJol lua require('jdtls').jol()]]
    vim.cmd[[command! -buffer JdtBytecode lua require('jdtls').javap()]]
    vim.cmd[[command! -buffer JdtJshell lua require('jdtls').jshell()]]
    vim.g.lsp_utils_location_opts = {
        height = 24,
        mode = 'split',
        list = {
            border = true,
            numbering = true
        },
        preview = {
            title = 'Location Preview',
            border = true,
        },
    }


    vim.g.lsp_utils_symbols_opts = {
        height = 24,
        mode = 'editor',
        list = {
            border = true,
            numbering = false,
        },
        preview = {
            title = 'Symbols Preview',
            border = true,
        },
        prompt = {}
    }


end

return M
