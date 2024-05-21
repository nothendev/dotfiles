{
  programs.nixvim.plugins = {
    cmp.enable = true;
    cmp.settings.experimental = { ghost_text.hlgroup = "Comment"; };
    cmp.settings.completion.completeopt = "menu,menuone,noselect,preview";
    cmp.settings.mapping = {
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      "<C-e>" = "cmp.mapping.close()";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<CR>" = ''
        cmp.mapping(function(fallback)
          local luasnip = require'luasnip'
          if cmp.visible() then
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              cmp.confirm({ select = false })
            end
          else
            fallback()
          end
        end)
      '';
      "<S-Tab>" = ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'})'';
      "<Tab>" = ''
        cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, {'i', 's'}
        )
      '';
    };
    cmp.settings.snippet.expand = "luasnip";
    cmp.settings.sources = [
      # { name = "codeium"; }
      { name = "supermaven"; }
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      {
        name = "buffer";
      }
      # { name = "path"; }
    ];
    cmp_luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
  };
}
