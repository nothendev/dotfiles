return {
  {
    "folke/which-key.nvim",
  },
  {
    "folke/todo-comments.nvim",
  },
  {
    "folke/trouble.nvim",
    opts = {
      mode = "document_diagnostics",
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      pickers = {
	find_files = {
	  find_command = { "fd", "--type", "f", "--follow", "--strip-cwd-prefix" }
	}
      }
    },
    cmd = { "Telescope" },
    keys = {
      { "<leader>ff", "<cmd>Telescope fd<CR>", desc = "[telescope] Search for files" },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "[telescope] Search in files (live grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[telescope] List buffers" },
      { "<leader>g", "<cmd>Telescope git_status<CR>", desc = "[telescope] Git status" },
      { "gs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "[telescope] Search document symbols" },
      { "gS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "[telescope] Search workspace symbols" },
    }
  },
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      detection_methods = { "pattern" },
      patterns = { ".git", "flake.nix", "rust-toolchain.toml" },
    },
    keys = {
      { "<leader>ps", "<cmd>Telescope projects<CR>", desc = "Projects" },
    },
    config = function(opts)
      require("project_nvim").setup(opts)
      require'telescope'.load_extension('projects')
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy"
  }
}
