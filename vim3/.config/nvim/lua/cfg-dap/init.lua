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
--dap.adapters.lldb = {
  --type = 'executable',
  --command = '/bin/lldb-vscode', -- adjust as needed, must be absolute path
  --name = 'lldb'
--}

--dap.configurations.cpp = {
    --{
      ---- If you get an "Operation not permitted" error using this, try disabling YAMA:
      ----  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --name = "Attach to process",
      --type = 'lldb',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      --request = 'attach',
      --pid = require('dap.utils').pick_process,
      --args = {},
    --},
--}



--dap.configurations.rust = dap.configurations.cpp

vim.fn.sign_define("DapStopped", { text = "⭕", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define("DapLogPoint", { text = "✳️ ", texthl = "", linehl = "", numhl = "" })
