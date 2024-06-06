local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options


  {
    "LunarVim/bigfile.nvim",
    lazy = true,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end,
    -- event="VeryLazy",
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
    -- event="VeryLazy",
    lazy = false,
  },

  -- override plugin configs
  -- {
  --   "williamboman/mason.nvim",
  -- opts = overrides.mason,
  -- event="VeryLazy",
  -- lazy = false,
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    config = function()
      require("custom.configs.treesitter")
    end,
    -- event="VeryLazy",
    lazy = false,
  },


  { --dependency
    "folke/neodev.nvim",
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })
    end,
    event = "VeryLazy",
  },
  -- Install a plugin
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   -- event="VeryLazy",
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- {
  --   "mg979/vim-visual-multi",
  --   event="VeryLazy",
  -- },
  -- {
  --   "sindrets/diffview.nvim",
  --   config = function()
  --     require "custom.configs.diffview"
  --   end,
  --   event="VeryLazy",
  -- },
  -- {
  --   "NeogitOrg/neogit",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",         -- required
  --     "nvim-telescope/telescope.nvim", -- optional
  --     -- "sindrets/diffview.nvim",        -- optional
  --   },
  --   -- config = function()
  --   --   require "custom.configs.neogit"
  --   -- end,
  --   event="VeryLazy",
  -- },
  {
    'f-person/git-blame.nvim',
    config = function()
      -- require("custom.configs.gitblame")
      require('gitblame').setup {
        --Note how the `gitblame_` prefix is omitted in `setup`
        enabled = false,
      }
    end,
    event = "VeryLazy",
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
  },
  {
    -- quick search and replace
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    pin = true,
    config = function()
      require('spectre').setup({ is_block_ui_break = true })
    end,
    -- event = "VeryLazy",
  },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   -- install jsregexp (optional!).
  --   build = "make install_jsregexp",
  --   event="VeryLazy",
  -- },
  {
    'fatih/vim-go',
    -- event = "VeryLazy",
    lazy = false,
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    event = "VeryLazy",
    config = function()
      require 'telescope'.setup {
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
    -- config = function()
    -- require("config.vimspector").setup()
    -- vim.cmd [[packadd! vimspector]] -- Load vimspector
    -- vim.g.vimspector_install_gadgets = {
    --   "debuggo",
    -- }
    -- end,
    -- event = "VeryLazy",
  },
  -- {
  --   "folke/trouble.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VeryLazy",
  -- },
  { -- extra refactor
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
    -- event = "VeryLazy",
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons'      -- optional
    },
    lazy = false,
  },
  {
    'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup()
    end,
    -- event="VeryLazy",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        -- version = "^1.0.0",
      },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("file_browser")
      require("custom.configs.telescope")
      require("telescope").load_extension("dir")
    end
  },
  -- {
  --   'mhinz/vim-grepper', event="VeryLazy",
  -- },
  -- {
  --   'hexdigest/gounit-vim', event="VeryLazy",
  -- },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  require("custom.configs.toggleterm"),
  -- require("custom.configs.indentline"),
  require("custom.configs.treesitter-context"), --show function name hover
  -- install without yarn or npm
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown", "md" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  --   config = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
  -- {
  --   'preservim/vim-markdown',
  --   event="VeryLazy"
  -- },
  -- {
  --     "JoosepAlviste/nvim-ts-context-commentstring",
  --     -- lazy = true,
  --     event = { "User FileOpened" },
  -- },
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
  -- {
  --   "kylechui/nvim-surround",
  --   -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   -- event = "VeryLazy",
  --   config = function()
  --     require("nvim-surround").setup({
  --       -- Configuration here, or leave empty to use defaults
  --     })
  --   end
  -- },
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
  -- {
  --   "roobert/search-replace.nvim",
  --   -- event="VeryLazy",
  --   -- lazy = true,
  --   cmd = {
  --     "SearchReplaceSingleBufferVisualSelection",
  --     "SearchReplaceWithinVisualSelection",
  --     "SearchReplaceWithinVisualSelectionCWord",
  --     "SearchReplaceSingleBufferSelections",
  --     "SearchReplaceSingleBufferCWord",
  --     "SearchReplaceSingleBufferCWORD",
  --     "SearchReplaceSingleBufferCExpr",
  --     "SearchReplaceSingleBufferCFile",
  --     "SearchReplaceMultiBufferSelections",
  --     "SearchReplaceMultiBufferOpen",
  --     "SearchReplaceMultiBufferCWord",
  --     "SearchReplaceMultiBufferCWORD",
  --     "SearchReplaceMultiBufferCExpr",
  --     "SearchReplaceMultiBufferCFile",
  --   },
  --   config = function()
  --     require("search-replace").setup({
  --       -- optionally override defaults
  --       default_replace_single_buffer_options = "gcI",
  --       default_replace_multi_buffer_options = "egcI",
  --     })
  --   end,
  -- },
  { --Syntax aware text-objects, select, move, swap, and peek support.
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
  },
  -- { --gen commentstring
  --   "danymat/neogen",
  --   config = true,
  --   -- Uncomment next line if you want to follow only stable versions
  --   -- version = "*",
  --   event = "VeryLazy",
  -- },
  {                  --A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger.
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {                                                        --A Vim wrapper for running tests on different granularities.
    'vim-test/vim-test',
    event = "VeryLazy",
  },
  {
    'fedepujol/move.nvim',
    event = "VeryLazy",
    config = function()
      require('move').setup({})
    end,
  },
  -- {
  --   'ctrlpvim/ctrlp.vim',
  --   event = "VeryLazy"
  -- },
  -- {
  --   'leoluz/nvim-dap-go',
  --   config = function()
  --     require('dap-go').setup {
  --       -- Additional dap configurations can be added.
  --       -- dap_configurations accepts a list of tables where each entry
  --       -- represents a dap configuration. For more details do:
  --       -- :help dap-configuration
  --       dap_configurations = {
  --         {
  --           -- Must be "go" or it will be ignored by the plugin
  --           type = "go",
  --           name = "Attach remote",
  --           mode = "remote",
  --           request = "attach",
  --         },
  --       },
  --       -- delve configurations
  --       delve = {
  --         -- the path to the executable dlv which will be used for debugging.
  --         -- by default, this is the "dlv" executable on your PATH.
  --         path = "dlv",
  --         -- time to wait for delve to initialize the debug session.
  --         -- default to 20 seconds
  --         initialize_timeout_sec = 20,
  --         -- a string that defines the port to start delve debugger.
  --         -- default to string "${port}" which instructs nvim-dap
  --         -- to start the process in a random available port
  --         port = "${port}",
  --         -- additional args to pass to dlv
  --         args = {
  --           '--check-go-version=false',
  --         },
  --         -- the build flags that are passed to delve.
  --         -- defaults to empty string, but can be used to provide flags
  --         -- such as "-tags=unit" to make sure the test suite is
  --         -- compiled during debugging, for example.
  --         -- passing build flags using args is ineffective, as those are
  --         -- ignored by delve in dap mode.
  --         build_flags = "",
  --         -- whether the dlv process to be created detached or not. there is
  --         -- an issue on Windows where this needs to be set to false
  --         -- otherwise the dlv server creation will fail.
  --         detached = true
  --       },
  --     }
  --   end,
  --   event = "VeryLazy",
  -- },
  {
    "folke/flash.nvim",
    -- event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "<a-s>",   mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "<a-s-f>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      -- vim.g.codeium_manual = true
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-i>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#Complete']() end, { expr = true, silent = true })
      -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  },
  {
    "princejoogie/dir-telescope.nvim",
    -- telescope.nvim is a required dependency
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup({
        -- these are the default options set
        hidden = true,
        no_ignore = false,
        show_preview = true,
      })

      vim.keymap.set("n", "<leader>dg", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>df", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
    end,
    -- event = "VeryLazy",
  },
  -- Rainbow Highlighting
  {
    -- "HiPhish/nvim-ts-rainbow2",
    "luochen1990/rainbow",
    -- event = 'VeryLazy',
    lazy = false,
    config = function()
      vim.g.rainbow_active = 1
    end
  },
  --   {'ray-x/navigator.lua', dependencies={'neovim/nvim-lspconfig','ray-x/guihua.lua'},
  --   config=function()
  --     require'navigator'.setup()
  --   end,
  --   lazy=false,
  -- },
  -- {'crispgm/nvim-go',dependencies={'nvim-lua/plenary.nvim','neovim/nvim-lspconfig'}, lazy=true},
  -- {'kevinhwang91/nvim-bqf', lazy=false},
  --  {--hint function args
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts) require'lsp_signature'.setup(opts) end
  -- },
  --  {
  --   "michaelb/sniprun",
  --   branch = "master",
  --   build = "sh install.sh",
  --   -- do 'sh install.sh 1' if you want to force compile locally
  --   -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
  --
  --   config = function()
  --     require("sniprun").setup({
  --     -- your options
  --     })
  --   end,
  --   lazy=true,
  -- },
  {
    "google/executor.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- your setup here
      require("executor").setup({})
    end,
    lazy = false,
  },
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
  {
    'nvim-java/nvim-java',
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-refactor',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      }
    },
    config = function()
      require('java').setup()
      require('lspconfig').jdtls.setup({})
    end,
    lazy = false,
  },
  {
    'mfussenegger/nvim-jdtls',
    lazy = false,
  },
  -- {
  --   "gongfeng-copilot",
  --   -- url = "git@git.woa.com:rockerchen/gongfeng-copilot.git",
  --   dir = "~/.config/nvim/pack/gongfeng/start/vim",
  --   lazy = false,
  --   event = "InsertEnter",
    -- -- config = function()
    -- --   vim.keymap.set('i', '<c-a>', function()
    -- --     return vim.call("copilot#Accept")
    -- --   end, { expr = true, silent = true })
    -- -- end,
    -- keys = {
    --   {
    --     "<c-a>",
    --     function()
    --       vim.call("copilot#Accept")
    --     end,
    --     mode = "i",
    --     desc = "Accept Copilot Suggestion",
    --   },
    -- },
    -- cond = function()
    --   local absolute_path = vim.fn.expand("%:p")
    --   if string.match(absolute_path, "secret") then
    --     return false
    --   end
    --   return true
    -- end,
  -- },
}

return plugins
