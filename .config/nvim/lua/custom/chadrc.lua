---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

vim.g.mapleader = ","

M.ui = {
  theme = "github_dark",
  theme_toggle = { "github_dark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h13.5"
elseif vim.g.goneovim then
  vim.o.guifont = "JetBrainsMono Nerd Font:h13.5"
elseif vim.g.fvim_loaded then
  vim.cmd [[FVimCursorSmoothMove v:true]]
  vim.cmd [[FVimCursorSmoothBlink v:true]]
  vim.o.guifont = "JetBrainsMono Nerd Font:h16"
else
  vim.o.guifont = "JetBrainsMono Nerd Font 13.5"
end
vim.filetype.add {
  extension = {
    astro = "astro",
    typst = "typst",
  },
}

return M
