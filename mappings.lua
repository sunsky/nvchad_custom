---@type MappingsTable
local M = {}


M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader><leader>fs"] = { '<cmd>lua require("spectre").toggle()<CR>', "toggle Spectre"  },
    ["<leader>fs"] = {'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',    "Search current word" },
    ["<leader>do"] = {'<cmd>DiffviewOpen<CR>',    "open diffview" },
    ["<leader>dc"] = {'<cmd>DiffviewClose<CR>',    "close diffview" },
    ["<leader>sf"] = {'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',     desc = "Search on current file"},
["<leader>fd"] = { function() 
	local builtin = require("telescope.builtin")
	local utils = require("telescope.utils")
	builtin.find_files({ cwd = utils.buffer_dir() }) 
end,
      desc = "Find files in cwd" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}



return M
