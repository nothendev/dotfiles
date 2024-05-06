{
  pkgs,
  nixvim,
  nvim,
  zls,
  system,
  osConfig,
  ...
}:
{
  imports = [
    nixvim.homeManagerModules.nixvim
    ./statusline.nix
    ./keymaps.nix
    ./cmp.nix
  ];
  programs.nixvim = {
    enable = true;
    package = nvim.packages.${system}.default;
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      settings.transparent_background = true;
    };
    clipboard.register = "unnamedplus";
    options = {
      ruler = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      guifont = "${osConfig.pretty.font.family}:h${toString osConfig.pretty.font.defaultSize}";
    };
    globals.mapleader = " ";
    # extraConfigLua = ''
    # require'tree-sitter-rstml'.setup()
    # require'nvim-ts-autotag'.setup()
    # '';
    extraPlugins = with pkgs.vimPlugins; [
      direnv-vim
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "tree-sitter-rstml";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "rayliwell";
      #     repo = "tree-sitter-rstml";
      #     rev = "eac3ef6ccd4192dc9d2c2103a0067a49cc1e435e";
      #     sha256 = "sha256-pmB/IeNumce5+em2vBUS7NwT0gEr5YuVLU4qaCQwt/A=";
      #   };
      # })
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "nvim-ts-autotag";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "rayliwell";
      #     repo = "nvim-ts-autotag";
      #     rev = "e4259bcf70ad489f58ade8e9abbb21526aceb270";
      #     sha256 = "sha256-Gcm+tE+oiecel+SgR0bcqfpdw3sJMnCoitXeMBKEpxg";
      #   };
      # })
    ];
    plugins = {
      # nvim-wide things
      indent-blankline.enable = true;
      bufferline.enable = true;
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
        enable = false;
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        messages.enabled = true;
        notify.enabled = true;
      };
      notify.enable = false;
      notify.backgroundColour = "#000000";
      flash.enable = true;
      twilight.enable = true;
      surround.enable = true;
      trouble.enable = true;
      trouble.mode = "document_diagnostics";
      refactoring.enable = true;
      fugitive.enable = true;
      gitgutter.enable = true;
      which-key.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = {
          addFile = "<leader>ha";
          navNext = "<leader>hj";
          navPrev = "<leader>hk";
        };
      };
      project-nvim.enable = true;
      project-nvim.detectionMethods = [
        "lsp"
        "pattern"
      ];
      project-nvim.patterns = [
        ".git"
        "flake.nix"
        "rust-toolchain.toml"
      ];
      presence-nvim = {
        enable = true;
        autoUpdate = true;
        mainImage = "neovim";
        showTime = true;
        fileAssets.rs = [
          "Rust"
          "https://www.rust-lang.org/logos/rust-logo-512x512.png"
        ];
        neovimImageText = "NEOVIM GAMING";
        buttons = [
          {
            label = "Codeberg";
            url = "https://codeberg.org/noth";
          }
          {
            label = "Minky Studios";
            url = "https://discord.gg/ARckZkKDk9";
          }
        ];
      };
      treesitter.enable = true;
      treesitter.ensureInstalled = [
        "vim"
        "lua"
        "regex"
        "bash"
        "markdown"
        "markdown_inline"
      ];
      leap.enable = true;
      persistence.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      nvim-lightbulb.enable = true;
      codeium-nvim = {
        enable = true;
      };
      ## completion
      lspkind = {
        enable = true;
        symbolMap = {
          Codeium = "󰚩";
        };
      };
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
          cargo.extraEnv.RUSTFLAGS = "-Clink-arg=-fuse-ld=mold";
          cargo.features = "all";
          cargo.targetDir = true;
          lens.enable = true;
          procMacro.ignored = {
            "leptos_macro" = [
              "component"
              "server"
              "island"
            ];
            "lemonic_macro" = [
              "component"
              "island"
            ];
          };
          checkOnSave = false;
        };
      };
      #leptos moment
      emmet.enable = true;
      ## js/ts
      lsp.servers.tsserver.enable = true;
      ## zig
      lsp.servers.zls.enable = false;
      lsp.servers.zls.package = zls.packages.${system}.zls;
    };
  };
  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [
    neovide
    # nvim.packages.${system}.neovim
    # neovim
  ];
}
