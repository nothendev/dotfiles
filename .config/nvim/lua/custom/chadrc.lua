---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

vim.g.mapleader = ","

M.ui = {
  theme = "acid_green_fanta",
  theme_toggle = { "github_dark", "acid_green_fanta" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

if vim.g.neovide then
  vim.o.guifont = "Monocraft Nerd Font:h13"
elseif vim.g.goneovim then
  vim.o.guifont = "Monocraft Nerd Font:h13"
else
  vim.o.guifont = "Monocraft Nerd Font 13"
end
vim.filetype.add {
  extension = {
    astro = "astro",
    typst = "typst",
  },
}

return M
