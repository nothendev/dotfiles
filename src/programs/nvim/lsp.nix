{ util }:
{ zls, system, pkgs, ... }: {
  programs.nixvim = {
    keymaps = with util.keymap;
      [
        (silent (keymapl "[LSP] Format the buffer" (l "fm") ''
          function()
            vim.lsp.buf.format{ async = true }
          end
        '' "n"))
      ];
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "supermaven-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "supermaven-inc";
          repo = "supermaven-nvim";
          rev = "264768c6b2a2e0480868e9dae443112e33b1484a";
          hash = "sha256-apbSGeqDJH2JHyf9ETDW0sn3pHecOkz7iZ9maBQ6zy4=";
        };
      })
    ];
    extraConfigLua = ''
      require'supermaven-nvim'.setup{
        disable_keymaps = true
      }
    '';
    plugins = {
      none-ls = {
        enable = true;
        sources.formatting.prettier.enable = true;
      };
      lspkind = {
        enable = true;
        symbolMap = { Supermaven = "󰚩"; };
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
      ## text stuff
      lsp.servers.marksman.enable = true;
      lsp.servers.taplo.enable = true;
      ## c/cpp
      lsp.servers.clangd.enable = true;
      ## nix
      nix.enable = true;
      lsp.servers.nixd = {
        enable = true;
        settings.formatting.command = [ "nixfmt" ];
      };
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
            "leptos_macro" = [ "component" "server" "island" ];
            "lemonic_macro" = [ "component" "island" ];
          };
          checkOnSave = false;
        };
      };

      #leptos moment
      emmet = {
        enable = true;
        extraConfig.leader_key = "<leader>e";
        extraConfig.mode = "n";
      };

      ## js/ts
      lsp.servers.tsserver.enable = true;
      lsp.servers.tsserver.onAttach.function = ''
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      '';

      ## zig
      lsp.servers.zls.enable = false;
      lsp.servers.zls.package = zls.packages.${system}.zls;
    };
  };
}
