return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      opts.cmdline = { enabled = false }
      opts.messages = { enabled = false }
      opts.debug = false
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      return opts
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      -- snacks provides input
      input = {
        enabled = false,
      },
    },
  },
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
      "echasnovski/mini.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    -- function() so that we can require'mini.fuzzy' ie it runs after mini loads
    opts = function()
      return {
        defaults = {
          generic_sorter = require("mini.fuzzy").get_telescope_sorter,
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--follow", "--strip-cwd-prefix" },
          },
        },
      }
    end,
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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    version = false,
    opts = {
      bigfile = { enabled = true },
      debug = { enabled = true },
      dim = { enabled = true },
      git = { enabled = true },
      rename = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      statuscolumn = { enabled = true },
    },
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    opts = {
      files = {},
      git = {},
    },
    config = function(self, opts)
      require("mini.files").setup(opts.files)
      require("mini.git").setup(opts.git)
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
      require("mini.fuzzy").setup()
    end,
    cmd = { "Git" },
    keys = {
      {
        "<leader>fa",
        function()
          MiniFiles.open()
        end,
      },
    },
  },
}
