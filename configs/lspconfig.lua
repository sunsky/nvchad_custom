local ok, wf = pcall(require, "vim.lsp._watchfiles")
  if ok then
     -- disable lsp watcher. Too slow on linux
     wf._watchfunc = function()
       return function()
          print("lsp watch files...")
       end
     end
  end


local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" ,"gopls","pyright","jdtls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
