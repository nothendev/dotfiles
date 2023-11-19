{ pkgs, nixvim, ... }:
{
  imports = [ nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    clipboard.register = "unnamedplus";
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      guifont = "JetBrainsMono Nerd Font Mono:h14";
    };
    globals.mapleader = " ";
    keymaps = [
      { action = ":"; key = "<M-x>"; }
      { action = "<cmd>w<CR>"; key = "<D-s>"; }
      { action = "^"; key = "<C-a>"; }
      { action = "vim.lsp.buf.format"; lua = true; key = "<leader>fm"; mode = "n"; options.silent = true; }
      { action = "<cmd>Telescope projects<CR>"; key = "<leader>ps"; mode = "n"; }
      { action = "<cmd>Telescope fd<CR>"; key = "<leader>ff"; mode = "n"; }
      { action = "<cmd>Telescope live_grep<CR>"; key = "<leader>fw"; mode = "n"; }
      { action = "<cmd>Telescope harpoon<CR>"; key = "<leader>h"; mode = "n"; }
      { action = "<cmd>Telescope lsp_document_symbols<CR>"; key = "gs"; mode = "n"; }
      { action = "<cmd>BufferLineCycleNext<CR>"; key = "<Tab>"; mode = "n"; options.silent = true; }
      { action = "<cmd>BufferLineCyclePrev<CR>"; key = "<S-Tab>"; mode = "n"; options.silent = true; }
      { action = "<cmd>bdelete<CR>"; key = "<leader>x"; mode = "n"; }
      { action = "<cmd>noh<CR>"; key = "<Esc>"; mode = "n"; options.silent = true; options.noremap = false; }
    ];
    extraConfigLua = ''
    local codeium = require'codeium'
    codeium.setup{}
    '';
    extraPlugins = with pkgs.vimPlugins; [ direnv-vim codeium-nvim ];
    plugins = {
      # nvim-wide things
      auto-save.enable = true;
      bufferline.enable = true;
      chadtree.enable = true;
      lualine = {
        enable = true;
        iconsEnabled = true;
      };
      luasnip.enable = true;
      luasnip.extraConfig.enable_autosnippets = true;
      comment-nvim.enable = true;
      comment-nvim.toggler = {
        line = "<leader>/";
        block = "<leader>?";
      };
      telescope.enable = true;
      rainbow-delimiters.enable = true;
      surround.enable = true;
      trouble.enable = true;
      refactoring.enable = true;
      none-ls.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      which-key.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = { };
      };
      project-nvim.enable = true;
      treesitter.enable = true;
      leap.enable = true;
      ## completion
      nvim-cmp.enable = true;
      nvim-cmp.experimental = { ghost_text.hlgroup = "Comment"; };
      nvim-cmp.completion.completeopt = "menu,menuone,noselect,preview";
      nvim-cmp.mapping = {
        "<C-Space>" = { action = "require'cmp'.mapping.complete()"; modes = [ "i" ]; };
        "<Tab>" = { action = ''
        function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end
        ''; modes = [ "i" "s" ]; };
        "<S-Tab>" = { action = ''
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end
        ''; modes = [ "i" "s" ]; };
        "<CR>" = { action = "require'cmp'.mapping.confirm{ behavior = require'cmp'.ConfirmBehavior.Replace, select = false }"; modes = [ "i" ]; };
      };
      nvim-cmp.snippet.expand = "luasnip";
      nvim-cmp.sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "codeium"; }
        { name = "buffer"; }
        { name = "path"; }
      ];
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      # languages
      lsp.enable = true;
      lsp.keymaps.diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lsp.keymaps.lspBuf = {
        K = "hover";
        gr = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
        "<leader>ca" = "code_action";
        "<leader>ra" = "rename";
      };
      cmp-nvim-lsp-signature-help.enable = true;
      ## nix
      nix.enable = true;
      lsp.servers.rnix-lsp.enable = true;
      ## rust
      crates-nvim.enable = true;
      rust-tools.enable = true;
      rust-tools.server.cargo.features = "all";
      lsp.servers.rust-analyzer = {
        enable = true;
        installLanguageServer = false;
        cmd = [ "/run/current-system/sw/bin/rust-analyzer" ];
        settings = {
          cargo.features = "all";
          lens.enable = true;
          procMacro.ignored = {
            "leptos_macro" = [ "component" "server" "island" ];
          };
        };
      };
      ## js/ts
      lsp.servers.tsserver.enable = true;
      ## zig
      zig.enable = true;
      lsp.servers.zls.enable = true;
    };
  };
  home.packages = with pkgs; [ neovide ];
}
