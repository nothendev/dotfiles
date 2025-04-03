{
  osConfig,
  ...
}:

{
  imports = [
    ./neofetch.nix
    ./neovim.nix
    ./pretty.nix
    ./configs.nix
    ./packages.nix
    ./fish.nix

    # Hyprland module
    #./hyprland.nix

    #../desktop/hypr.home.nix
    ../desktop/river.home.nix

    ../programs/vcs.home.nix
    ../programs/terminal.home.nix
  ];

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.XDG_DATA_HOME = "/home/ilya/.local/share";
  home.sessionVariables.JAVA_HOME = "/etc/jvm/gr22";

  home.username = "ilya";
  home.homeDirectory = "/home/ilya";
  home.stateVersion = osConfig.system.stateVersion;
  programs.home-manager.enable = true;
}
