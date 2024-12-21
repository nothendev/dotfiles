-- nvim-cmp
local C = {
  "hrsh7th/nvim-cmp",
  version = false,
  dependencies = {
    { "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "supermaven",
    "lspkind",
  },
  event = "InsertEnter",
  lazy = true,
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      experimental = { ghost_text = { hlgroup = "Comment" } },
      completion = {
        completeopt = "menu,menuone,noselect,preview",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if cmp.visible() then
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              cmp.confirm({ select = false })
            end
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(0) then
            luasnip.jump(0)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = "supermaven" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}

-- blink.cmp
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
    build = "nix run .#build-plugin",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        list = {
          selection = "auto_insert",
        },
        ghost_text = {
          enabled = true,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = {
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
        ["<C-Space>"] = { "show", "fallback" },
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
