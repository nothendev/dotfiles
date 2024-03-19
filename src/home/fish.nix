{ config, pkgs, catppuccin-fish, ... }: {
  programs.fish.enable = true;
  home.file.".config/fish/themes".source = catppuccin-fish + "/themes";
  programs.fish.interactiveShellInit = ''
    ${pkgs.zoxide}/bin/zoxide init fish --cmd j | source
  '';
  programs.fish.functions = { stfd = "sudo shutdown --no-wall 0"; };
  programs.fish.shellAliases = {
    l = "eza -l --icons";
    ls = "eza --icons";
  };
  programs.direnv.enable = true;
}
