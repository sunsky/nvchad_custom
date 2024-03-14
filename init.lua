
-- Predefine clipboard provider to speedup start
--

vim.api.nvim_set_option("clipboard","unnamed")

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })


-- Refactor
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set( "n", "<leader>rI", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")


-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
--     pattern = "*",
--     callback = function()
--     -- require'symbols-outline'.open_outline()
--       -- vim.api.nvim_set_keymap("n", "<F9>", ":!echo test<CR>", {silent = false})
--       -- vim.cmd ":SymbolsOutlineOpen"
--       vim.cmd ":NvimTreeOpen"
--     end
-- })



vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")



function copypath()
    local path = vim.fn.expand("%:p")
    vim.notify('Copied "' .. path .. '" to the clipboard!')
    -- vim.fn.setreg("+", path)
end
vim.keymap.set('n', '<leader>cp', copypath, { noremap = true })
