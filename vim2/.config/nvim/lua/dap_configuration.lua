
local dap = require('dap')
dap.configurations.java = {
    {
        type = 'java';
        request = 'attach';
        name = "Debug (Attach) - Remote";
        hostName = "127.0.0.1";
        port = 5005;
    },
}

dap.configurations.jbehave = {
    {
        type = 'jbehave';
        request = 'attach';
        name = "Debug (Attach) - Remote";
        hostName = "127.0.0.1";
        port = 5005;
    },
}
dap.adapters.lldb = {
    type = 'executable',
    command = '/bin/lldb-vscode', -- adjust as needed
    name = "lldb"
}

require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='⭐️', texthl='DAPLogPointSign', linehl='', numhl='DAPLogPointSign'})
vim.fn.sign_define('DapStopped', {text='➡️l', texthl='', linehl='debugPC', numhl=''})
