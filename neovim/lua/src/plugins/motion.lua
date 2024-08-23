return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
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
