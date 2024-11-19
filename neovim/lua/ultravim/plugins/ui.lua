return {
  { "folke/which-key.nvim", event = "VeryLazy" },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--follow", "--strip-cwd-prefix" },
        },
      },
    },
    cmd = { "Telescope" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "[telescope] Search for files" },
      { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "[telescope] Search in files (live grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[telescope] List buffers" },
      { "<leader>g", "<cmd>Telescope git_status<CR>", desc = "[telescope] Git status" },
      { "gs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "[telescope] Search document symbols" },
      { "gS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "[telescope] Search workspace symbols" },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {}
  }
}
