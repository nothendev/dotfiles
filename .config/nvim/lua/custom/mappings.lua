---@type MappingsTable
local M = {}

if vim.g.neovide then
  vim.g.neovide_input_use_logo = 1

  M.general = {
    n = {
      ["<D-v>"] = { '"+P', "paste" },
    },
    i = {
      ["<D-v>"] = { '<ESC>l"+Pli', "paste" },
      ["<C-s>"] = { "<ESC>:w <CR>i", "save in insert mode" },
    },
    v = {
      ["<D-v>"] = { '"+P', "paste" },
      ["<D-c>"] = { '"+y', "copy" },
    },
    c = {
      ["<D-v>"] = { "<C-R>+" },
    },
  }
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>dd"] = { '"_dd', "voids a line" },
  },
}

M.harpoon = {
  plugin = true,
  n = {
    ["<M-h>"] = { "lua require('harpoon.ui').nav_prev()", "harpoon previous mark" },
    ["<M-l>"] = { "lua require('harpoon.ui').nav_next()", "harpoon next mark" },
    ["<M-g>"] = { "lua require('harpoon.mark').add_file()", "harpoon mark curr file" },
  },
}

M.nvimtree = {
  plugin = true,
  n = {
    ["<leader>el"] = { "<cmd> NvimTreeFindFile <CR>", "locate file in NvimTree" },
  },
}

return M
