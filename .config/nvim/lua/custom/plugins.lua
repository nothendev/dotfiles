local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

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
      -- {
      --   "williamboman/mason-lspconfig.nvim",
      --   config = function(_, opts)
      --     require("mason-lspconfig").setup(opts)
      --   end,
      -- },
      -- "mason.nvim"
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "aspeddro/gitui.nvim",
    cmd = "Gitui",
    config = function()
      require("gitui").setup()
    end,
  },

  {
    "tpope/vim-surround",
    lazy = false,
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-tree.lua",
    },
    config = function()
      require("harpoon").setup {
        global_settings = {
          save_on_toggle = true,
        },
      }
      require("core.utils").load_mappings "harpoon"
    end,
  },

  {
    "MrcJkb/haskell-tools.nvim",
    dependencies = {
      "plenary.nvim",
      "telescope.nvim",
    },
    ft = "haskell",
    config = function()
      local on_attach = require("plugins.configs.lspconfig").on_attach
      require("haskell-tools").start_or_attach {
        hls = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
          end,
        },
      }
    end,
  },

  {
    "editorconfig/editorconfig-vim",
    event = "BufWrite",
    enabled = false,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        css = true,
        mode = "virtualtext",
        tailwind = "both",
        virtualtext = "■",
        names = false,
        sass = { enable = true, parsers = { "css" } },
      },
    },
  },

  {
    "icedman/nvim-textmate",
    ft = { "stylus" },
    opts = {
      quickload = true,
    },
    config = function(_, opts)
      require("nvim-textmate").setup(opts)
    end,
    enabled = false,
  },

  {
    "jcdickinson/codeium.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {}
    end,
  },

  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = {
      "plenary.nvim",
    },
    opts = {
      null_ls = {
        enabled = true,
        name = "crates",
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },

  {
    "IndianBoy42/tree-sitter-just",
    event = { "BufRead justfile", "BufRead .justfile" },
    dependencies = {
      "nvim-treesitter",
    },
    config = function(_, opts)
      require("tree-sitter-just").setup(opts)
    end,
  },

  {
    "jbyuki/instant.nvim",
    cmd = {
      "InstantStartSingle",
      "InstantJoinSingle",
      "InstantStartSession",
      "InstantJoinSession",
      "InstantStartServer",
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function(_, opts)
      require('trouble').setup(opts)
    end
  },

  {
    "andweeb/presence.nvim",
    opts = require("custom.configs.presence"),
    config = function(_, opts)
      require("presence").setup(opts)
    end
  }
}

return plugins
