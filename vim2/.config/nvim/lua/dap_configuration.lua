local config = {}


config['init_options'] = {
  bundles = {
    vim.fn.glob("/home/maren/Download/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
  };
}

config['on_attach'] = function(client, bufnr)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end


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
