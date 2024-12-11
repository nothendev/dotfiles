return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" }, function()
          require("snacks").notify.info("formatted", {
            title = "conform",
          })
        end)
      end,
      desc = "[conform] format",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      rust = { "rustfmt" },
      nix = { "nixfmt" },
      lua = { "stylua" },
      javascript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
