vim.lsp.inlay_hint.enable(true)
vim.api.nvim_set_keymap("n", "<C-a>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-a>", "^", { noremap = true, silent = true })

return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      disable_keymaps = true,
    },
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local ls = require("null-ls")
      ls.setup({
        sources = {
	  ls.builtins.formatting.biome,
          ls.builtins.formatting.prettier,
          ls.builtins.formatting.stylua,
        },
      })
    end,
    keys = {
      { "<leader>fm", "<cmd>lua vim.lsp.buf.format{async=true}<CR>", desc = "Format buffer" },
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = {
      symbolMap = { Supermaven = "󰚩" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lc = require("lspconfig")
      local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

      lc.marksman.setup({
        capabilities = cmp_caps,
      })
      lc.taplo.setup({
        capabilities = cmp_caps,
      })
      lc.clangd.setup({
        capabilities = cmp_caps,
      })
      lc.nixd.setup({
        capabilities = cmp_caps,
        settings = {
          nixd = {
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      })
      lc.rust_analyzer.setup({
        capabilities = cmp_caps,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              --extraEnv = {
              --  RUSTFLAGS = "-Clink-arg=-fuse-ld=mold",
              --},
              features = "all",
              targetDir = true,
            },
            lens = {
              enable = true,
            },
            procMacro = {
              ignored = {
                ["leptos_macro"] = { "component", "server", "island" },
                ["lemonic_macro"] = { "component", "island" },
              },
            },
            checkOnSave = false,
          },
        },
      })
      lc.tsserver.setup({
        capabilities = cmp_caps,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- oh typescript.
          local ts_sem_remap = {
            typescriptExport = "@keyword.export",
            typescriptImport = "@keyword.import",
          }

          for k, v in pairs(ts_sem_remap) do
            vim.api.nvim_set_hl(0, k, { link = v })
          end
        end,
      })
      lc.gopls.setup({
        capabilities = cmp_caps,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
	    hints = {
	      assignVariableTypes = true,
	      compositeLiteralFields = true,
	      constantValues = true,
	      functionTypeParameters = true,
	      parameterNames = true,
	      rangeVariableTypes = true,
	    }
          },
        },
      })
      lc.svelte.setup({
        capabilities = cmp_caps,
      })
      lc.zls.setup({
        capabilities = cmp_caps,
      })
      lc.lua_ls.setup({
        capabilities = cmp_caps,
      })
    end,
    keys = {
      { "]]", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Next diagnostic" },
      { "[[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "Prev diagnostic" },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
      { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition" },
      { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
      { "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Type definition" },
      { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
      { "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
    },
    ft = {
      "toml",
      "markdown",
      "markdown_inline",
      "c",
      "cpp",
      "go",
      "nix",
      "typescript",
      "javascript",
      "svelte",
      "zig",
      "lua",
      "rust",
    },
  },
}
