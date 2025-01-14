{
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
  };
  programs.fish.shellAliases = {
    l = "eza -l --icons";
    ls = "eza --icons";
    cp = "rsync -P";
    zcp = "rsync --info=progress2 -auvz";
    k = "kubectl";
  };
  programs.fish.shellInit = ''
    set -gx PATH $HOME/.bun/bin $HOME/go/bin $PATH
  '';
  programs.direnv.enable = true;
}
