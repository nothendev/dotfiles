return {
  {
    "folke/flash.nvim",
  },
  {
    "theprimeagen/harpoon",
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension('harpoon')
    end,
    keys = {
      { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "[harpoon] mark" },
      { "<leader><leader>", "<cmd>Telescope harpoon marks<CR>", desc = "[telescope] harpoon marks" },
      { "<Tab>", "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "[harpoon] next" },
      { "<S-Tab>", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "[harpoon] prev" },
    }
  }
}
