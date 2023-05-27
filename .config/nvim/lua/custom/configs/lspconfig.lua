local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
  "marksman",
  "taplo",
  "astro",
  "svelte",
  "tailwindcss",
  "angularls",
  "vuels",
  "emmet_ls",
  "graphql"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      }
    },
  },
  root_dir = function(fname)
    local util = lspconfig.util
    local cargo_crate_dir = util.root_pattern "Cargo.toml"(fname)
    local cmd = { "/home/ilya/.cargo/bin/cargo", "metadata", "--no-deps", "--format-version", "1" }
    if cargo_crate_dir ~= nil then
      cmd[#cmd + 1] = "--manifest-path"
      cmd[#cmd + 1] = util.path.join(cargo_crate_dir, "Cargo.toml")
    end
    local cargo_metadata = ""
    local cargo_metadata_err = ""
    local cm = vim.fn.jobstart(cmd, {
      on_stdout = function(_, d, _)
        cargo_metadata = table.concat(d, "\n")
      end,
      on_stderr = function(_, d, _)
        cargo_metadata_err = table.concat(d, "\n")
      end,
      stdout_buffered = true,
      stderr_buffered = true,
    })
    if cm > 0 then
      cm = vim.fn.jobwait({ cm })[1]
    else
      cm = -1
    end
    local cargo_workspace_dir = nil
    if cm == 0 then
      cargo_workspace_dir = vim.json.decode(cargo_metadata)["workspace_root"]
      if cargo_workspace_dir ~= nil then
        cargo_workspace_dir = util.path.sanitize(cargo_workspace_dir)
      end
    else
      vim.notify(
        string.format("[lspconfig] cmd (%q) failed:\n%s", table.concat(cmd, " "), cargo_metadata_err),
        vim.log.levels.WARN
      )
    end
    return cargo_workspace_dir
      or cargo_crate_dir
      or util.root_pattern "rust-project.json"(fname)
      or util.find_git_ancestor(fname)
  end,
}
lspconfig.typst_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  single_file_support = true,
}

--
-- lspconfig.pyright.setup { blabla}
