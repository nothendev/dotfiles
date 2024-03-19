{ pkgs, nixvim, nvim, zls, system, osConfig, ... }: {
  imports = [ nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    package = nvim.packages.${system}.default;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    clipboard.register = "unnamedplus";
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      guifont = "${osConfig.pretty.font.family}:h${
          toString osConfig.pretty.font.defaultSize
        }";
    };
    globals.mapleader = " ";
    keymaps = [
      # i catch myself doing that too often so disable it here xd
      {
        action = "function()print'stop doing ctrl-s you dumbass'end";
        key = "<D-s>";
        lua = true;
      }
      {
        action = "^";
        key = "<C-a>";
      }
      {
        action = "0";
        key = "<C-Tab>";
        mode = "n";
      }
      {
        action = "function()vim.lsp.buf.format{async=true}end";
        lua = true;
        key = "<leader>fm";
        mode = "n";
        options.silent = true;
      }
      {
        action = "<cmd>Telescope projects<CR>";
        key = "<leader>ps";
        mode = "n";
      }
      {
        action = "<cmd>Telescope fd<CR>";
        key = "<leader>ff";
        mode = "n";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fw";
        mode = "n";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        mode = "n";
      }
      {
        action = "<cmd>Telescope git_status<CR>";
        key = "<leader>g";
        mode = "n";
      }
      #{
      #  action = "<cmd>Telescope harpoon marks<CR>";
      #  key = "<leader><leader>";
      #  mode = "n";
      #}
      {
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        key = "gs";
        mode = "n";
      }
      {
        action = "<cmd>BufferLineCycleNext<CR>";
        key = "<Tab>";
        mode = "n";
        options.silent = true;
      }
      {
        action = "<cmd>BufferLineCyclePrev<CR>";
        key = "<S-Tab>";
        mode = "n";
        options.silent = true;
      }
      {
        action = "<cmd>bdelete<CR>";
        key = "<leader>x";
        mode = "n";
      }
      {
        action = "<cmd>noh<CR>";
        key = "<Esc>";
        mode = "n";
        options.silent = true;
        options.noremap = false;
      }
      {
        action = "<Esc>";
        key = "<C-c>";
        options.silent = true;
      }
      {
        action = "function()vim.diagnostic.open_float{border='rounded'}end";
        key = "<leader>f";
        mode = "n";
        lua = true;
      }
    ];
    extraConfigLua = "";
    extraPlugins = with pkgs.vimPlugins; [ direnv-vim ];
    plugins = {
      # nvim-wide things
      indent-blankline.enable = true;
      bufferline.enable = true;
      chadtree.enable = true;
      lualine = {
        enable = true;
        iconsEnabled = true;
        globalstatus = true;
      };
      luasnip.enable = true;
      luasnip.extraConfig.enable_autosnippets = true;
      comment-nvim.enable = true;
      comment-nvim.toggler = {
        line = "<leader>/";
        block = "<leader>?";
      };
      telescope.enable = true;
      telescope.extensions.project-nvim.enable = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      noice = {
        enable = true;
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        messages.enabled = true;
        notify.enabled = true;
      };
      notify.enable = true;
      surround.enable = true;
      trouble.enable = true;
      trouble.mode = "document_diagnostics";
      refactoring.enable = true;
      fugitive.enable = true;
      gitgutter.enable = true;
      which-key.enable = true;
      harpoon = {
        enable = false;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>ha";
          navNext = "<leader>hj";
          navPrev = "<leader>hk";
        };
      };
      project-nvim.enable = true;
      project-nvim.detectionMethods = [ "lsp" "pattern" ];
      project-nvim.patterns = [ ".git" "rust-toolchain.toml" ];
      presence-nvim = {
        enable = true;
        autoUpdate = true;
        mainImage = "neovim";
        showTime = true;
        fileAssets.rs =
          [ "Rust" "https://www.rust-lang.org/logos/rust-logo-512x512.png" ];
        neovimImageText = "NEOVIM GAMING";
      };
      treesitter.enable = true;
      treesitter.ensureInstalled =
        [ "vim" "lua" "regex" "bash" "markdown" "markdown_inline" ];
      leap.enable = true;
      persistence.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      nvim-lightbulb.enable = true;
      codeium-nvim = { enable = true; };
      ## completion
      lspkind = {
        enable = true;
        symbolMap = { Codeium = "󰚩"; };
      };
      cmp.enable = true;
      cmp.settings.experimental = { ghost_text.hlgroup = "Comment"; };
      cmp.settings.completion.completeopt = "menu,menuone,noselect,preview";
      cmp.settings.mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping(cmp.mapping.confirm({ select = true }), {'i'})";
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
                      end
                    , {'i', 's'})'';
      };
      cmp.settings.snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';
      cmp.settings.sources = [
        { name = "codeium"; }
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
      nix-develop.enable = true;

      # languages
      lspsaga = {
        enable = true;
        # nvim-lightbulb instead of this
        lightbulb.enable = false;
      };
      lsp.enable = true;
      lsp.keymaps.diagnostic = {
        "]]" = "goto_next";
        "[[" = "goto_prev";
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
      ## c/cpp
      lsp.servers.ccls.enable = true;
      ## nix
      nix.enable = true;
      lsp.servers.nixd.enable = true;
      ## rust
      crates-nvim.enable = true;
      lsp.onAttach = ''
        vim.lsp.inlay_hint.enable(bufnr, true)
      '';
      lsp.servers.rust-analyzer = {
        enable = true;
        package = null;
        cmd = null;
        installCargo = false;
        installRustc = false;
        settings = {
          cargo.features = "all";
          lens.enable = true;
          procMacro.ignored = {
            "leptos_macro" = [ "component" "server" "island" ];
            "lemonic_macro" = [ "component" "island" ];
          };
          checkOnSave = false;
        };
      };
      ## js/ts
      lsp.servers.tsserver.enable = true;
      ## zig
      lsp.servers.zls.enable = false;
      lsp.servers.zls.package = zls.packages.${system}.zls;
    };
  };
  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs;
    [
      neovide
      # nvim.packages.${system}.neovim
      # neovim
    ];
}
