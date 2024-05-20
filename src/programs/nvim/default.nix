{
  pkgs,
  nixvim,
  nvim,
  system,
  osConfig,
  ...
}:
{
  imports =
    [ nixvim.homeManagerModules.nixvim ]
    ++ (
      let
        util = import ./util.nix;
      in
      map
        (
          mod:
          let
            m = import mod;
          in
          if builtins.typeOf m == "set" then m else (m { inherit util; })
        )
        [
          ./lsp.nix
          ./statusline.nix
          ./motion.nix
          ./cmp.nix
          ./ui.nix
        ]
    );
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
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      guifont = "${osConfig.pretty.font.family}:h${toString osConfig.pretty.font.defaultSize}";
    };
    globals.mapleader = " ";
    plugins = {
      # nvim-wide things
      direnv.enable = true;
      indent-blankline.enable = true;
      luasnip.enable = true;
      luasnip.extraConfig.enable_autosnippets = true;
      refactoring.enable = true;
      fugitive.enable = true;
      project-nvim.enable = true;
      project-nvim.detectionMethods = [
        "pattern"
      ];
      project-nvim.patterns = [
        ".git"
        "flake.nix"
        "rust-toolchain.toml"
      ];
      neocord.enable = true;
      neocord.settings = {
        auto_update = true;
        main_image = "language";
        show_time = true;
        file_assets.rs = [
          "Rust"
          "https://www.rust-lang.org/logos/rust-logo-512x512.png"
        ];
        neovim_image_text = "coding!11!!!!!111!";
        buttons = [
          {
            label = "My dotfiles (NixOS)";
            url = "https://codeberg.org/noth/dotfiles";
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
      persistence.enable = true;
      nvim-colorizer.enable = true;
      codeium-nvim = {
        enable = false;
      };
      nix-develop.enable = true;
    };
  };
  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [ neovide ];
}
