return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "[trouble] diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[trouble] buf diagnostics" },
    { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "[trouble] symbols" },
    { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "[trouble] lsp stuff" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "[trouble] loclist" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "[trouble] quickfixlist" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous Trouble/Quickfix Item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next Trouble/Quickfix Item",
    },
  },
}
