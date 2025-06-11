local B = {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "saghen/blink.compat", lazy = true, opts = {} },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "supermaven" },
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
                  -- return (
                  -- require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                  -- or "BlinkCmpKind"
                  -- ) .. ctx.kind
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
        default = { "supermaven", "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          supermaven = {
            name = "supermaven",
            --kind_icon = "󰚩",
            module = "blink.compat.source",
            score_offset = 200,
          },
        },
      },
    },
  },
}

return B
