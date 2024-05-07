{
  pkgs,
  nixvim,
  nvim,
  system,
  osConfig,
  ...
}:
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ] ++ (let util = import ./util.nix; in map (mod: let m = import mod; in
    if builtins.typeOf m == "set" then m
    else (m { inherit util; })
  ) [
    ./lsp.nix
    ./statusline.nix
    ./keymaps.nix
    ./cmp.nix
    ./ui.nix
  ]);
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
    # extraConfigLua = ''
    # require'tree-sitter-rstml'.setup()
    # require'nvim-ts-autotag'.setup()
    # '';
    plugins = {
      # nvim-wide things
      direnv.enable = true;
      indent-blankline.enable = true;
      luasnip.enable = true;
      luasnip.extraConfig.enable_autosnippets = true;
      comment-nvim.enable = true;
      comment-nvim.toggler = {
        line = "<leader>c";
        block = "<leader>C";
      };
      refactoring.enable = true;
      fugitive.enable = true;
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
      nix-develop.enable = true;
    };
  };
  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [
    neovide
    # nvim.packages.${system}.neovim
    # neovim
  ];
}
