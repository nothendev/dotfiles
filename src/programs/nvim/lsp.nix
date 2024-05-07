{ util }:
{ zls, system, ... }:
{
  programs.nixvim = {
    keymaps = with util.keymap; [
      (silent (keymapl (l"fm") ''
        function()
          vim.lsp.buf.format{ async = true }
        end
      '' "n"))
    ];
    plugins = {
      lspkind = {
        enable = true;
        symbolMap = {
          Codeium = "󰚩";
        };
      };
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
      lsp.servers.nixd = {
        enable = true;
        settings.formatting.command = "nixfmt";
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
      emmet = {
        enable = true;
        extraConfig.leader_key = "<leader>e";
        extraConfig.mode = "n";
      };

      ## js/ts
      lsp.servers.tsserver.enable = true;
      ## zig
      lsp.servers.zls.enable = false;
      lsp.servers.zls.package = zls.packages.${system}.zls;
    };
  };
}
