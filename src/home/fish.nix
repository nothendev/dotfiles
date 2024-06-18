{
  config,
  pkgs,
  catppuccin-fish,
  ...
}:
{
  programs.fish.enable = true;
  home.file.".config/fish/themes".source = catppuccin-fish + "/themes";
  programs.fish.interactiveShellInit = ''
    ${pkgs.zoxide}/bin/zoxide init fish --cmd j | source
  '';
  programs.fish.functions = {
    stfd = "sudo shutdown --no-wall 0";
    tarcp = "tar cf - $0 | (cd $1 && tar xf -)";
  };
  programs.fish.shellAliases = {
    l = "eza -l --icons";
    ls = "eza --icons";
    cp = "rsync -P";
    zcp = "rsync --info=progress2 -auvz";
  };
  programs.fish.shellInit = ''
  . $HOME/.nix-profile/etc/profile.d/nix.fish
  '';
  programs.direnv.enable = true;
}
