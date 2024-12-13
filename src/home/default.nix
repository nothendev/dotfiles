{
  pkgs,
  osConfig,
  neovim-nightly-overlay,
  system,
  ...
}:

{
  imports = [
    ./neofetch.nix
    ./pretty.nix
    ./configs.nix
    ./packages.nix
    ./fish.nix

    # Hyprland module
    ./hyprland.nix

    ../desktop/hypr.home.nix
    ../desktop/river.home.nix

    ../programs/vcs.home.nix
    ../programs/terminal.home.nix
  ];

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.XDG_DATA_HOME = "/home/ilya/.local/share";
  home.packages =
    [
      neovim-nightly-overlay.packages.${system}.default
      #zls.packages.${system}.zls
    ]
    ++ (with pkgs; [
      neovide
      stylua
      lua-language-server
      svelte-language-server
      typescript-language-server
      nixd
      taplo-lsp
      marksman
      #lua
      luajit
      luarocks
      gopls
      gofumpt
      metals
    ]);

  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
