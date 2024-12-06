vim.lsp.inlay_hint.enable(true)
vim.api.nvim_set_keymap("n", "<C-a>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-a>", "^", { noremap = true, silent = true })

pcall(vim.keymap.del, "n", "grn")
pcall(vim.keymap.del, { "n", "x" }, "gra")
pcall(vim.keymap.del, "n", "grr")

return {
  {
    "mfussenegger/nvim-dap",
    name = "dap",
    lazy = true,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>ds",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>dS",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
      },
    },
    config = function()
      local dap = require("dap")
      dap.configurations.java = {
        {
          type = "java",
          name = "Attach to pick process",
          request = "attach",
          pid = require("dap.utils").pick_process,
          args = {},
        },
        {
          type = "java",
          name = "Attach to :5005",
          request = "attach",
          hostName = "localhost",
          port = 5005,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "dap",
    },
    ft = { "java" },
  },
  {
    "supermaven-inc/supermaven-nvim",
    name = "supermaven",
    opts = {
      disable_keymaps = true,
    },
    lazy = true,
  },
  {
    "onsails/lspkind.nvim",
    name = "lspkind",
    opts = {
      symbolMap = { Supermaven = "󰚩" },
    },
    lazy = true,
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt" },
    opts = function()
      local metals_config = require("metals").bare_config()
      --metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
      --end
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
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
                ["vespid_macros"] = { "component" }
              },
            },
            checkOnSave = false,
          },
        },
      })
      lc.ts_ls.setup({
        capabilities = cmp_caps,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          client.server_capabilities.semanticTokensProvider = nil

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
            },
          },
        },
      })
      local ngserver_cmd = {
        "ngserver",
        "--stdio",
        "--tsProbeLocations",
        "/mnt/k/minky/ultrarepo",
        "--ngProbeLocations",
        "/mnt/k/minky/ultrarepo",
      }
      lc.angularls.setup({
        capabilities = cmp_caps,
        cmd = ngserver_cmd,
        root_dir = lc.util.root_pattern("nx.json", "angular.json", ".git"),
        on_new_config = function(new_config, new_root_dir)
          new_config.cmd =
            { "ngserver", "--stdio", "--tsProbeLocations", new_root_dir, "--ngProbeLocations", new_root_dir }
        end,
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
      "html",
      "typescript",
      "javascript",
      "typescriptreact",
      "typescript.tsx",
      "htmlangular",
      "svelte",
      "zig",
      "lua",
      "rust",
    },
  },
}
