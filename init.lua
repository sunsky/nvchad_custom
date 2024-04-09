
-- Predefine clipboard provider to speedup start

vim.api.nvim_set_option("clipboard","unnamed")

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })


vim.o.autoread = true

vim.g["go_term_enabled"] = 1
vim.g["go_term_mode"] = "split"
vim.g["go_test_show_name"] = 1

-- vim.api.nvim_set_var()
vim.g['test#strategy'] = "neovim"
