---@type MappingsTable
local M = {}

vim.o.langmap = "шiЖ:фaсcцwрhоjлkдlгuкrб\\,йq"

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
    ["<leader>fpm"] = { ":%!prettier %", "formats current file with prettier" },
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

M.telescope = {
  plugin = true,
  n = {
    ["<leader>cd"] = { "<cmd> Telescope diagnostics <CR>", "show diagnostics" },
    ["gs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "show / goto symbol(s)" },
    ["gS"] = { "<cmd> Telescope lsp_workspace_symbols <CR>", "show / goto symbol(s) in entire workspace" },
  },
}

local tabnext = { "<cmd> tabnext <CR>", "next tab", { noremap = true, silent = true } }
local tabprev = { "<cmd> tabprevious <CR>", "previous tab", { noremap = true, silent = true } }

M.tabufline = {
  plugin = true,
  n = {
    ["<C-e>e"] = tabnext,
    ["<C-e>E"] = tabprev,
    ["<C-e>q"] = { "<cmd> tabclose <CR>", "close tab" },
    ["<C-e>n"] = { "<cmd> tabnew <CR>", "new tab" },
  },
}

return M
