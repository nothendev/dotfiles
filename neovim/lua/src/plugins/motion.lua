return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
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
        desc = "Remote Flash",
      },
      --{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      {
        "<leader>s",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "theprimeagen/harpoon",
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension("harpoon")
    end,
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "[harpoon] mark",
      },
      { "<leader><leader>", "<cmd>Telescope harpoon marks<CR>", desc = "[telescope] harpoon marks" },
      {
        "<Tab>",
        function()
          require("harpoon.ui").nav_next()
        end,
        desc = "[harpoon] next",
      },
      {
        "<S-Tab>",
        function()
          require("harpoon.ui").nav_prev()
        end,
        desc = "[harpoon] prev",
      },
    },
  },
}
