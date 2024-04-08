---@type MappingsTable
local M = {}


-- Shorten function name
local keymap = vim.api.nvim_set_keymap -- vim.keymap.set
-- Silent keymap option
local opts = {
  silent = true,
  -- nowait = true,
  noremap = true,
  }

M.general = {
  n = {
    ["<leader>gc"] = {"<cmd>lua require'neogen'.generate()<cr>", "gen comment"},

    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- ["<leader><leader>fs"] = { '<cmd>lua require("spectre").toggle()<CR>', "toggle Spectre"  },
    ["<leader>fs"] = {'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',    "Search current word" },
    -- ["<leader>do"] = {'<cmd>DiffviewOpen<CR>',    "open diffview" },
    -- ["<leader>dc"] = {'<cmd>DiffviewClose<CR>',    "close diffview" },
    ["<leader>fc"] = {'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',     desc = "Search on current file"},
["<leader>fd"] = { function() 
	local builtin = require("telescope.builtin")
	local utils = require("telescope.utils")
	builtin.find_files({ cwd = utils.buffer_dir() }) 
end,
      desc = "Find files in cwd" },

    ["<leader>tf"]={"<cmd>GoTestFunc -v<cr>",  opts=opts},
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

--
-- --Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--
-- -- Modes
-- --   normal_mode = "n",
-- --   insert_mode = "i",
-- --   visual_mode = "v",
-- --   visual_block_mode = "x",
-- --   term_mode = "t",
-- --   command_mode = "c",
--
-- -- Git
keymap("n", "<leader>gl", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
-- -- Normal --
-- Center cursor during vertical navigation
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
--
-- -- Center cursor during search navigation
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
--
-- -- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
--
-- -- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -2<CR>", opts)
--
-- -- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
--
-- -- Clear highlights
-- keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)
--
-- -- Close buffers
-- keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)
--
-- -- Better paste
keymap("v", "p", "P", opts)
--
-- -- Insert --
-- -- Press jk fast to switch to Normal mode
keymap("i", "jk", "<ESC>", opts)
--
--

-- -- Move text up and down
-- keymap("n", "<M-j>", ":m .+1<CR>==", opts)
-- keymap("n", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- Normal-mode commands
vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-h>', ':MoveWord(-1)<CR>', opts)
vim.keymap.set('n', '<A-l>', ':MoveWord(1)<CR>', opts)
-- vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
-- vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)

-- Visual-mode commands
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

--
-- -- Visual --
-- -- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
--
-- -- Visual Block --
-- -- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
--
-- -- Plugins --
--
-- -- NvimTree
-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
--
-- -- Telescope
-- keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
-- keymap("n", "<C-o>", ":Telescope fd cwd=~/") -- keymap("n", "<leader>f", ":Telescope current_buffer_fuzzy_find<CR>", opts) -- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- -- keymap("n", "<leader>fo", ":Telescope live_grep cwd=/home/prashant/Git", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<space>fd", ":Telescope file_browser<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
--
-- -- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
-- keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

--
-- -- DAP
keymap("n","<leader>ds", ':lua require("dapui").setup();require("dapui").open()<cr>',  opts)
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dn", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<S-F7>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>df", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require('dap-go').debug_test()<cr>", opts)
keymap("n", "<leader>dk", "<cmd>lua require('dapui').eval()<cr>", opts)

-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>sl", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})


-- open file_browser with the path of the current buffer
-- vim.keymap.set("n", "<space>fp", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
--
-- Testing




return M
