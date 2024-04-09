local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  { "folke/neodev.nvim", opts = {} , config =function()
    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    require("neodev").setup({
      -- add any options here, or leave empty to use the default settings
    })
  end,
  lazy = false,
},
{
  "neovim/nvim-lspconfig",
  dependencies = {
    -- format & linting
    {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
  },
  config = function()
    require "plugins.configs.lspconfig"
    require "custom.configs.lspconfig"
  end, -- Override to setup mason-lspconfig
  lazy = false,
},

-- override plugin configs
{
  "williamboman/mason.nvim",
  opts = overrides.mason,
  lazy = false,
},

{
  "nvim-treesitter/nvim-treesitter",
  opts = overrides.treesitter,
  config = function ()
    require("custom.configs.treesitter")
  end,
  lazy = false,
},



-- Install a plugin
{
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  config = function()
    require("better_escape").setup()
  end,
},

-- To make a plugin not be loaded
{
  "NvChad/nvim-colorizer.lua",
  lazy = false,
},

-- All NvChad plugins are lazy-loaded by default
{
  "mg979/vim-visual-multi",
  lazy = false,
},
-- {
--   "sindrets/diffview.nvim",
--   config = function()
--     require "custom.configs.diffview"
--   end,
--   lazy = false,
-- },
{
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    -- "sindrets/diffview.nvim",        -- optional
  },
  -- config = function()
  --   require "custom.configs.neogit"
  -- end,
  lazy = false,
},
{
  'f-person/git-blame.nvim',
  config = function()
    -- require("custom.configs.gitblame")
    require('gitblame').setup {
      --Note how the `gitblame_` prefix is omitted in `setup`
      enabled = true,
    }
  end,
  lazy = false,
},
{
  'rcarriga/nvim-dap-ui',
  dependencies = {
    "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"
  },
  config = function()
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })
  end,
  lazy = false,
  -- event = "VeryLazy"

},
{
  -- quick search and replace
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    require('spectre').setup({ is_block_ui_break = true })

  end,
  lazy = false,
},
{
  'ldelossa/nvim-ide',
  config = function()
    require("custom.configs.ide")
  end,
  lazy = false,
},
{
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  init = function()
    require("core.utils").load_mappings "nvimtree"
  end,
  opts = function()
    return  require "custom.configs.nvimtree"
  end,
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "nvimtree")
    require("nvim-tree").setup(opts)
  end,
  lazy = false,
},
-- git stuff
{
  "lewis6991/gitsigns.nvim",
  ft = { "gitcommit", "diff" },
  -- init = function()
  -- load gitsigns only when a git file is opened
  -- vim.api.nvim_create_autocmd({ "BufRead" }, {
  --   group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
  --   callback = function()
  --     vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
  --     if vim.v.shell_error == 0 then
  --       vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
  --       vim.schedule(function()
  --         require("lazy").load { plugins = { "gitsigns.nvim" } }
  --       end)
  --     end
  --   end,
  -- })
  -- end,
  opts = function()
    return require("plugins.configs.others").gitsigns
  end,
  -- config = function(_)
  --   dofile(vim.g.base46_cache .. "git")
  --   require('gitsigns').setup {
  --     signs = {
  --       add          = { text = '│' },
  --       change       = { text = '│' },
  --       delete       = { text = '_' },
  --       topdelete    = { text = '‾' },
  --       changedelete = { text = '~' },
  --       untracked    = { text = '┆' },
  --     },
  --     signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  --     numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  --     linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
  --     word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
  --     watch_gitdir = {
  --       follow_files = true
  --     },
  --     attach_to_untracked = true,
  --     current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  --     current_line_blame_opts = {
  --       virt_text = true,
  --       virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
  --       delay = 1000,
  --       ignore_whitespace = false,
  --     },
  --     current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  --     sign_priority = 6,
  --     update_debounce = 100,
  --     status_formatter = nil, -- Use default
  --     max_file_length = 40000, -- Disable if file is longer than this (in lines)
  --     preview_config = {
  --       -- Options passed to nvim_open_win
  --       border = 'single',
  --       style = 'minimal',
  --       relative = 'cursor',
  --       row = 0,
  --       col = 1
  --     },
  --     yadm = {
  --       enable = false
  --     },
  --   }    end,
  lazy = false,
},
{
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    require'alpha'.setup(require'alpha.themes.startify'.config)
  end,
  lazy = false,
},
{
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  lazy = false
},
-- {
--   "NvChad/nvterm",
--   init = function()
--     require("core.utils").load_mappings "nvterm"
--   end,
--   config = function(_, opts)
--     require "base46.term"
--     require("nvterm").setup(opts)
--   end,
--   lazy = false,
-- },
{
  'fatih/vim-go',
  lazy = false,
},
{
  'buoto/gotests-vim',
  lazy = false,
},
{
  'nvim-telescope/telescope-media-files.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  lazy = false,
  config = function ()
    require'telescope'.setup {
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          -- filetypes = {"png", "webp", "jpg", "jpeg"},
          -- find command (defaults to `fd`)
          find_cmd = "rg"
        }
      },
    }
  end,
},
{
  "puremourning/vimspector",
  cmd = { "VimspectorInstall", "VimspectorUpdate" },
  fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
  config = function()
    -- require("config.vimspector").setup()
    -- vim.cmd [[packadd! vimspector]] -- Load vimspector
    -- vim.g.vimspector_install_gadgets = {
    --   "debuggo", 
    -- }
  end,
  lazy = false,
},
{
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
},
{
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()
  end,
  lazy = false,
},
{
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({})
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons'     -- optional
  },
  lazy = false,
},
{
  'simrat39/symbols-outline.nvim',
  config = function ()
    require("symbols-outline").setup()
  end,
  -- lazy = false,
},
{
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim" ,
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      -- version = "^1.0.0",
    },
    -- {
    --   'ahmedkhalf/project.nvim',
    --   config =function ()
    --     require("project_nvim").setup({
    --       manual_mode=true,
    --         patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    --         silent_chdir = false,
    --          detection_methods = { --[[ "lsp", ]] "pattern" },
    --
    --     })
    --   end
    -- },
  },
  config = function()
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("file_browser")
    require("custom.configs.telescope")
  end
},
{
  'mhinz/vim-grepper', lazy = false,
},
{
  'hexdigest/gounit-vim', lazy=false,
},
{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
},
require("custom.configs.toggleterm"),
require("custom.configs.indentline"),
require("custom.configs.treesitter-context"),
-- install without yarn or npm
{
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown","md" },
  build = function() vim.fn["mkdp#util#install"]() end,
  config = function()
      vim.fn["mkdp#util#install"]()
  end,
},
-- {
--   'preservim/vim-markdown',
--   event="VeryLazy"
-- },
{
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    event = { "User FileOpened" },
},
-- {
--     "ggandor/leap.nvim",
    -- lazy = true,
    -- keys = { "r", "R", "W", "dr", "dR", "yr", "yR", "cr", "cR" },
    -- config = function()
        -- require("leap").opts.highlight_unlabeled_phase_one_targets = true
        -- leap.add_default_mappings()
        -- vim.keymap.set({ "x", "o", "n" }, "r", "<Plug>(leap-forward-to)")
        -- vim.keymap.set({ "x", "o", "n" }, "R", "<Plug>(leap-backward-to)")
        -- vim.keymap.set({ "x", "o", "n" }, "W", "<Plug>(leap-from-window)")
    -- end,
-- },
{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},
-- {
--     "zbirenbaum/neodim",
--     lazy = true,
--     event = "LspAttach",
--     config = function()
--         require("neodim").setup({
--             alpha = 0.75,
--             blend_color = "#000000",
--             update_in_insert = {
--                 enable = true,
--                 delay = 100,
--             },
--             hide = {
--                 virtual_text = true,
--                 signs = false,
--                 underline = false,
--             },
--         })
--     end,
-- },
{
  "roobert/search-replace.nvim",
  -- lazy = false,
  -- lazy = true,
    cmd = {
        "SearchReplaceSingleBufferVisualSelection",
        "SearchReplaceWithinVisualSelection",
        "SearchReplaceWithinVisualSelectionCWord",
        "SearchReplaceSingleBufferSelections",
        "SearchReplaceSingleBufferCWord",
        "SearchReplaceSingleBufferCWORD",
        "SearchReplaceSingleBufferCExpr",
        "SearchReplaceSingleBufferCFile",
        "SearchReplaceMultiBufferSelections",
        "SearchReplaceMultiBufferOpen",
        "SearchReplaceMultiBufferCWord",
        "SearchReplaceMultiBufferCWORD",
        "SearchReplaceMultiBufferCExpr",
        "SearchReplaceMultiBufferCFile",
    },
  config = function()
    require("search-replace").setup({
      -- optionally override defaults
      default_replace_single_buffer_options = "gcI",
      default_replace_multi_buffer_options = "egcI",
    })

  end,
},
{
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = { "nvim-treesitter/nvim-treesitter" }
},
-- {
--   "epwalsh/obsidian.nvim",
--   version = "*",  -- recommended, use latest release instead of latest commit
--   lazy = true,
--   ft = "markdown",
--   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
--   -- event = {
--   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
--   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
--   --   "BufReadPre path/to/my-vault/**.md",
--   --   "BufNewFile path/to/my-vault/**.md",
--   -- },
--   dependencies = {
--     -- Required.
--     "nvim-lua/plenary.nvim",
--
--     -- see below for full list of optional dependencies 👇
--   },
--   opts = {
--     workspaces = {
--       {
--         name = "personal",
--         path = "~/obsidian_personal",
--       },
--       {
--         name = "work",
--         path = "~/obsidian_work",
--       },
--     },
--
--     -- see below for full list of options 👇
--   },
-- },
-- {
--   "github/copilot.vim",
--   event = 'VeryLazy',
-- },
{
  "danymat/neogen",
  config = true,
  -- Uncomment next line if you want to follow only stable versions
   version = "*",
   event = "VeryLazy",
},
-- {
--   "ray-x/go.nvim",
--   dependencies = {  -- optional packages
--     "ray-x/guihua.lua",
--     "neovim/nvim-lspconfig",
--     "nvim-treesitter/nvim-treesitter",
--   },
--   config = function()
--     require("go").setup()
--   end,
--   event = {"CmdlineEnter"},
--   ft = {"go", 'gomod'},
--   build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
-- },
-- {
--   'vim-test/vim-test',
--   lazy = false,
-- }
-- {
--   'moll/vim-bbye',
--   lazy = false,
-- },
{ 
    'fedepujol/move.nvim',
    event = "VeryLazy",
    config=function ()
      require('move').setup({})
    end,
},
{'ctrlpvim/ctrlp.vim',event="VeryLazy"},
{'leoluz/nvim-dap-go',config=function ()
  require('dap-go').setup {
    -- Additional dap configurations can be added.
    -- dap_configurations accepts a list of tables where each entry
    -- represents a dap configuration. For more details do:
    -- :help dap-configuration
    dap_configurations = {
      {
        -- Must be "go" or it will be ignored by the plugin
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
      },
    },
    -- delve configurations
    delve = {
      -- the path to the executable dlv which will be used for debugging.
      -- by default, this is the "dlv" executable on your PATH.
      path = "dlv",
      -- time to wait for delve to initialize the debug session.
      -- default to 20 seconds
      initialize_timeout_sec = 20,
      -- a string that defines the port to start delve debugger.
      -- default to string "${port}" which instructs nvim-dap
      -- to start the process in a random available port
      port = "${port}",
      -- additional args to pass to dlv
      args = {
        '--check-go-version=false',
      },
      -- the build flags that are passed to delve.
      -- defaults to empty string, but can be used to provide flags
      -- such as "-tags=unit" to make sure the test suite is
      -- compiled during debugging, for example.
      -- passing build flags using args is ineffective, as those are
      -- ignored by delve in dap mode.
      build_flags = "",
      -- whether the dlv process to be created detached or not. there is
      -- an issue on Windows where this needs to be set to false
      -- otherwise the dlv server creation will fail.
      detached = true
    },
  } 
  end,
  event = "VeryLazy",
},
-- Lua
-- {
--   "folke/persistence.nvim",
--   event = "BufReadPre", -- this will only start session saving when an actual file was opened
--   opts = {
--     -- add any custom options here
--   }
-- },
{
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    }
  end,
  lazy=false,
},
{
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "<c-f>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<a-s-f>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
},
-- {
--   "jackMort/ChatGPT.nvim",
--     event = "VeryLazy",
--     config = function()
--       require("chatgpt").setup()
--     end,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "folke/trouble.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
-- },
{
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  config = function ()
    -- Change '<C-g>' here to any keycode you like.
    -- vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    -- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
    -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
    -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  end
},
{'edluffy/hologram.nvim',
  config = function()
    require('hologram').setup({
      auto_display = true -- WIP automatic markdown image display, may be prone to breaking
    })
  end
}

}

return plugins
