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
{
  "sindrets/diffview.nvim",
  config = function()
    require "custom.configs.diffview"
  end,
  lazy = false,
},
{
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
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
    'mfussenegger/nvim-dap',
    'windwp/windline.nvim'
  },
  config = function()
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })
  end,
  lazy = false,

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
{
  "NvChad/nvterm",
  init = function()
    require("core.utils").load_mappings "nvterm"
  end,
  config = function(_, opts)
    require "base46.term"
    require("nvterm").setup(opts)
  end,
  lazy = false,
},
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
  'https://github.com/adelarsq/image_preview.nvim',
  event = 'VeryLazy',
  config = function()
    require("image_preview").setup()
  end,
  lazy =false,
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
  lazy = false,
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
  },
  config = function()
    require("telescope").load_extension("live_grep_args")
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ['<C-p>'] = require('telescope.actions.layout').toggle_preview
          }
        },
        preview = {
          hide_on_startup = true -- hide previewer when picker starts
        }
      },

    })
  end
},
{
  'mhinz/vim-grepper', lazy = false,
},
{
  'hexdigest/gounit-vim', lazy=false,
},


    }

    return plugins
