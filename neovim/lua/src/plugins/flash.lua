return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "[flash] jmp",
    },
    {
      "?",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "[flash] treesitter",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ search = { forward = false, wrap = false, multi_window = false } })
      end,
      desc = "[flash] -jmp",
    },
    --{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "[flash] remote",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<leader>s",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
