--codeberg.org/noth/dotfiles - nvim config (v0.12+ required for vim.pack)

local opts = {}

opts.g = {
  mapleader = " ",
  maplocalleader = "\\",
  neovide_opacity = 1,
  cord_defer_startup = true
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
  guifont = "JetBrainsMono Nerd Font Mono:h13",
  foldlevel = 99,
  foldlevelstart = 99
}

for namespace, options in pairs(opts) do
  for key, value in pairs(options) do
    vim[namespace][key] = value
  end
end

vim.keymap.set("n", "<leader>S", ":update<CR>:source<CR>")
vim.keymap.set("n", "<CR>", "za")
vim.keymap.set({ "n", "i", "v", "x" }, "<C-a>", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v", "x" }, "<C-c>", "<Esc>", { noremap = true })
for _, k in pairs({ 'n', 'a', 'r', 't', 'i', 't' }) do
  pcall(vim.keymap.del, { "n", "x" }, 'gr' .. k)
end
vim.api.nvim_create_user_command("W", function() vim.cmd("update") end, {})

vim.pack.add({
  "https://github.com/v1nh1shungry/error-lens.nvim",
  "https://github.com/glacambre/firenvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.extra",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/Saecki/crates.nvim",
  "https://github.com/saghen/blink.compat",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/folke/trouble.nvim",
  -- "https://github.com/folke/tokyonight.nvim",
  "https://github.com/chrisgrieser/nvim-origami",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/tjdevries/present.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/vyfor/cord.nvim",
  "https://github.com/rhysd/vim-llvm",
  "https://github.com/vague-theme/vague.nvim",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main"
  },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range('1.*'),
  }
})

require"flash".setup {}
require"nvim-surround".setup {}
require"crates".setup()
require"mini.pick".setup()
vim.ui.select = MiniPick.ui_select
require"mini.icons".setup()
require"mini.extra".setup()
require"fidget".setup {}
require"error-lens".setup {}
require"oil".setup {
  columns = { "icon" },
  view_options = {
    show_hidden = true
  }
}
require"cord".setup{
  advanced = {
    server = {
      update = 'install'
    }
  },
  display = {
    theme = 'catppuccin',
    view = 'asset',
  }
}

require"present".setup {
  syntax = {
    stop = "---"
  }
}

require"supermaven-nvim".setup {
  disable_keymaps = true,
  disable_inline_completion = true,
}
require"blink.cmp".setup {
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
require"trouble".setup{
  focus = true,
  auto_close = true
}
require"nvim-treesitter".install{'rust','lua'}
require"origami".setup{
  autoFold = {
    enabled = false
  },
  foldKeymaps = {
    setup = false
  }
}

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
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gs", function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename)
vim.keymap.set("n", "<Right>", function() require("origami").l() end)
vim.keymap.set("n", "gh", ":LspClangdSwitchSourceHeader<CR>")
vim.keymap.set({ "n", "x", "o" }, "s", function() require'flash'.jump() end)
vim.keymap.set({ "n", "x", "o" }, "S", function() require'flash'.jump({ forward = false }) end)
vim.keymap.set("o", "o", function() require'flash'.remote() end)
vim.keymap.set({"o", "x"}, "R", function() require'flash'.treesitter_search() end)
vim.keymap.set({"c"}, "<C-u>", function() require'flash'.toggle() end)
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>")
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>")
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>")
local function runflycheck() vim.lsp.buf_notify(0, 'rust-analyzer/runFlycheck', { textDocument = vim.lsp.util.make_text_document_params() }) end
vim.keymap.set("n", "<leader>C", runflycheck)
vim.keymap.set("n", "<C-S-C>", runflycheck)

vim.lsp.config("*", {
  capabilities = require'blink.cmp'.get_lsp_capabilities(),
})

vim.lsp.config("rust_analyzer", {
  cmd = { 'env', 'LD_PRELOAD=/lib/libsnmallocshim.so', 'rust-analyzer' },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        --extraEnv = {
        --  RUSTFLAGS = "-Clink-arg=-fuse-ld=mold",
        --},
        buildScripts = { enable = true },
        features = "all",
      },
      -- lru = {
      --   capacity = 32767
      -- },
      -- numThreads = 8,
      checkOnSave = false
    },
  }
})

vim.lsp.enable({
  "clangd",
  "lua_ls",
  "rust_analyzer",
  "ts_ls",
})

-- require "tokyonight".setup {
--   style = "night",
--   transparent = false
-- }

require"vague".setup {}

vim.cmd [[
  colorscheme vague
  hi DiagnosticUnderlineError cterm=underline gui=underline
  hi DiagnosticUnderlineWarn cterm=underline gui=underline
  hi DiagnosticUnderlineInfo cterm=underline gui=underline
  hi DiagnosticUnderlineHint cterm=underline gui=underline
  hi DiagnosticUnderlineOk cterm=underline gui=underline
  hi statusline guibg=none
  hi WinSeparator guibg=none
  hi VertSplit guibg=none
]]
