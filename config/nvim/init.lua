--codeberg.org/noth/dotfiles - nvim config (v0.12+ required for vim.pack)

local opts = {}

opts.g = {
  mapleader = " ",
  maplocalleader = "\\",
  neovide_opacity = 1
}

opts.o = {
  linebreak = true,
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  clipboard = "unnamedplus",
  tabstop = 2,
  expandtab = true,
  signcolumn = "yes",
  winborder = "rounded",
  swapfile = false,
  guifont = "JetBrainsMono Nerd Font Mono:h13"
}

for namespace, options in pairs(opts) do
  for key, value in pairs(options) do
    vim[namespace][key] = value
  end
end

vim.keymap.set("n", "<leader>S", ":update<CR>:source<CR>")
vim.keymap.set({ "n", "i", "v", "x" }, "<C-a>", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v", "x" }, "<C-c>", "<Esc>", { noremap = true })
for _, k in pairs({ 'n', 'a', 'r', 't', 'i', 't' }) do
  pcall(vim.keymap.del, { "n", "x" }, 'gr' .. k)
end

vim.pack.add({
  "https://github.com/glacambre/firenvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.extra",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/vague2k/vague.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/Saecki/crates.nvim",
  "https://github.com/saghen/blink.compat",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/chrisgrieser/nvim-origami",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/tjdevries/present.nvim",
  "https://github.com/folke/flash.nvim",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main"
  },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range('1.*'),
  }
})

require "flash".setup {
  modes = {
    search = {
      enabled = true,
    }
  }
}
require "nvim-surround".setup {}
require "crates".setup()
require "mini.pick".setup()
vim.ui.select = MiniPick.ui_select
require "mini.icons".setup()
require "mini.extra".setup()
require "fidget".setup {}
require "oil".setup {
  columns = { "icon" },
  view_options = {
    show_hidden = true
  }
}

require "present".setup {
  syntax = {
    stop = "---"
  }
}

require "supermaven-nvim".setup {
  disable_keymaps = true,
  disable_inline_completion = true,
}
require "blink.cmp".setup {
  fuzzy = {
    frecency = {
      enabled = false
    }
  },
  completion = {
    list = {
      selection = { preselect = true, auto_insert = true },
    },
    ghost_text = {
      enabled = false,
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

require"nvim-treesitter".install{'rust','lua'}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'rust', 'lua' },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.keymap.set("n", "<leader>ff",
  function()
    local path = vim.fs.root(vim.fs.dirname(vim.api.nvim_buf_get_name(0)), { '.git', 'Cargo.toml' })
    MiniPick.builtin.cli(
      { command = { 'fd', '--type=f', '--color=never', '--no-ignore', '--fixed-strings', '--search-path', path } },
      {
        source = {
          name = 'Files',
          show = function(buf_id, items, query)
            local prefix_data = vim.tbl_map(function(x)
              local icon, hl = MiniIcons.get('file', x)
              return { text = icon .. ' ' .. string.sub(x, string.len(path) + 2), hl = hl }
            end, items)

            MiniPick.default_show(buf_id, prefix_data, query)

            local ns_id = vim.api.nvim_create_namespace('MiniPickRanges')
            local icon_extmark_opts = { hl_mode = 'combine', priority = 200 }
            for i = 1, #prefix_data do
              icon_extmark_opts.hl_group = prefix_data[i].hl
              icon_extmark_opts.end_row, icon_extmark_opts.end_col = i - 1, 1
              pcall(vim.api.nvim_buf_set_extmark, buf_id, ns_id, i - 1, 0, icon_extmark_opts)
            end
          end
        }
      })
  end)
vim.keymap.set("n", "<leader>fw", ":Pick grep_live tool='rg'<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")
vim.keymap.set("n", "-", require "oil".toggle_float)
vim.keymap.set("n", "<leader>-", ":Oil<CR>")
vim.keymap.set("n", "<leader>O", require "oil".toggle_float)
vim.keymap.set("n", "<leader>o", ":source %<CR>")
vim.keymap.set("n", "<leader>C", "1z=")
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gs", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename)
vim.keymap.set("n", "<Left>", function() require("origami").h() end)
vim.keymap.set("n", "<Right>", function() require("origami").l() end)
vim.keymap.set("n", "gh", ":LspClangdSwitchSourceHeader<CR>")
vim.keymap.set({ "n", "x", "o" }, "s", function() require'flash'.jump() end)
vim.keymap.set({ "n", "x", "o" }, "S", function() require'flash'.jump({ forward = false }) end)
vim.keymap.set({ "n", "x", "o" }, "?", function() require'flash'.treesitter() end)
vim.keymap.set("o", "o", function() require'flash'.remote() end)
vim.keymap.set({"o", "x"}, "R", function() require'flash'.treesitter_search() end)
vim.keymap.set({"c"}, "<C-u>", function() require'flash'.toggle() end)

vim.lsp.enable({
  "clangd",
  "lua_ls",
  "rust_analyzer",
  "ts_ls",
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

require "tokyonight".setup {
  style = "night",
  transparent = false
}

vim.cmd [[
  colorscheme tokyonight-night
  hi statusline guibg=none
  hi WinSeparator guibg=none
  hi VertSplit guibg=none
  "call firenvim#install(0)
]]
