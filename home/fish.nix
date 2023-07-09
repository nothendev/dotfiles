{ config, pkgs, ... }: {
  programs.fish.enable = true;
  programs.fish.functions = {
    l = ''
      exa -1amFhl --icons $argv
    '';
  };
  programs.direnv.enable = true;
}
