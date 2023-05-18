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
      {
        "williamboman/mason-lspconfig.nvim",
        config = function(_, opts)
          require("mason-lspconfig").setup(opts)
        end,
      },
      "mason.nvim"
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

  -- Install a plugin
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
  },

  {
    "NvChad/nvim-colorizer.lua",
    options = {
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
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {}
    end,
  },
}

return plugins
