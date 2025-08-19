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
  winborder = "rounded",
  swapfile = false
}

for namespace, options in pairs(opts) do
  for key, value in pairs(options) do
    vim[namespace][key] = value
  end
end

vim.keymap.set("n", "<leader>o", ":update<CR>:source<CR>")
-- vim.keymap.set({ "n", "i", "v", "x" }, "<C-a>", "0", { noremap = true })
vim.keymap.set({ "n", "i", "v", "x" }, "<C-c>", "<Esc>", { noremap = true })

vim.pack.add({
  -- "https://github.com/glacambre/firenvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/echasnovski/mini.pick",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/vague2k/vague.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/Saecki/crates.nvim",
  "https://github.com/saghen/blink.compat",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main"
  },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range('1.*'),
  }
})

require "crates".setup()
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
    },
  },
  keymap = {
    preset = "enter",
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<CR>"] = {
      "accept",
      "fallback",
    },
  },
  sources = {
    default = { "supermaven", "lsp", "path", "snippets" },
    providers = {
      supermaven = {
        name = "supermaven",
        module = "blink.compat.source",
        score_offset = 200,
      },
    },
  },
}

-- require"nvim-treesitter".install{'rust','lua'}

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'rust', 'lua' },
--   callback = function()
--     vim.treesitter.start()
--   end,
-- })

vim.keymap.set("n", "<leader>ff", ":Pick files tool='fd'<CR>")
vim.keymap.set("n", "<leader>fw", ":Pick grep_live tool='rg'<CR>")
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")
vim.keymap.set("n", "<leader>O", ":Oil<CR>")
vim.keymap.set("n", "<leader>C", "1z=")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.lsp.enable({
  "lua_ls",
  "rust_analyzer"
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        --extraEnv = {
        --  RUSTFLAGS = "-Clink-arg=-fuse-ld=mold",
        --},
        buildScripts = { enable = true },
        features = "all",
        targetDir = true,
      },
      diagnostics = {
        disabled = { "proc-macro-disabled", "proc-macros-disabled" },
      },
      lens = {
        enable = true,
      },
      procMacro = {
        ignored = {
          ["leptos_macro"] = { "component", "server", "island" },
          ["vespid_macros"] = { "component" },
        },
      },
      checkOnSave = false,
    },
  }
})

vim.cmd("colorscheme vague")
vim.cmd("hi statusline guibg=bg")
-- vim.cmd("call firenvim#install(0)")
