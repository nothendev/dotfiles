--codeberg.org/noth/dotfiles - nvim config (v0.12+!!!)
local opts = {}

opts.g = {
  mapleader = " ",
  maplocalleader = "\\",
}

opts.o = {
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  clipboard = "unnamedplus",
  tabstop = 2,
  expandtab = true,
  signcolumn = "yes",
  winborder = "rounded"
}

for namespace, options in pairs(opts) do
  for key, value in pairs(options) do
    vim[namespace][key] = value
  end
end

vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
vim.keymap.set({ "n", "i", "v", "x" }, "<C-a>", "0", { noremap = true })
vim.keymap.set({ "n", "i", "v", "x" }, "<C-c>", "<Esc>", { noremap = true })

vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/echasnovski/mini.pick",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/vague2k/vague.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/saghen/blink.compat",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range('1.*'),
  }
})

require "mini.pick".setup()
require "oil".setup()
require "vague".setup {
  transparent = true
}
require "supermaven-nvim".setup {
  disable_keymaps = true,
  disable_inline_completion = true,
}
require "blink.cmp".setup {
  fuzzy = {
    use_frecency = false,
  },
  completion = {
    list = {
      selection = { preselect = false, auto_insert = true },
    },
    ghost_text = {
      enabled = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    menu = {
      max_height = 20,
      draw = {
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              if ctx.source_name == "supermaven" then
                return "󰚩"
              end

              local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
              return hl
            end,
          },
        },
      },
    },
  },
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<CR>"] = {
      function(cmp)
        cmp.hide()
        cmp.accept()
      end,
      "fallback",
    },
  },
  sources = {
    default = { "supermaven", "lsp", "path", "snippets", "buffer" },
    providers = {
      supermaven = {
        name = "supermaven",
        module = "blink.compat.source",
        score_offset = 200,
      },
    },
  },
}

vim.keymap.set("n", "<leader>ff", ":Pick files tool='fd'<CR>")
vim.keymap.set("n", "<leader>fw", ":Pick grep_live tool='rg'<CR>")
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

vim.lsp.enable({
  "lua_ls",
  "rust-analyzer"
})

vim.cmd("colorscheme vague")
vim.cmd("hi statusline guibg=bg")
