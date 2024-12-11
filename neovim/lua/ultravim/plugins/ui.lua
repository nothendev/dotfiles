return {
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
    opts = {
      bigfile = { enabled = true },
      debug = { enabled = true },
      dim = { enabled = true },
      git = { enabled = true },
      rename = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 1300,
      },
      statuscolumn = { enabled = true },
    },
    config = function(self, opts)
      require("snacks").setup(opts)

      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
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
