-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("ultravim.map")
require("ultravim.opts")

local lazyFile_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
-- This autocmd will only trigger when a file was loaded from the cmdline.
-- It will render the file as quickly as possible.
vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function(event)
    -- Skip if we already entered vim
    if vim.v.vim_did_enter == 1 then
      return
    end

    -- Try to guess the filetype (may change later on during Neovim startup)
    local ft = vim.filetype.match({ buf = event.buf })
    if ft then
      -- Add treesitter highlights and fallback to syntax
      local lang = vim.treesitter.language.get_lang(ft)
      if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
        vim.bo[event.buf].syntax = ft
      end

      -- Trigger early redraw
      vim.cmd([[redraw]])
    end
  end,
})

-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")

Event.mappings.LazyFile = { id = "LazyFile", event = lazyFile_events }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

require("lazy").setup({
  spec = {
    { import = "ultravim.plugins" },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
        local transparent = true
        -- make bg catppuccin base (set bg to transparent in term because term already has catppuccin base as bg)
        if vim.g.neovide then
          transparent = false
        end

        require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = transparent,
        })

        vim.cmd.colorscheme("catppuccin")
      end,
    },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true },
})
