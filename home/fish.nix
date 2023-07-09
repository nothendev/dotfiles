{ config, pkgs, ... }:
{
  programs.fish.enable = true;
  programs.fish.functions = [
    ''
      function l
      exa -1amFhl --icons $argv
      end
    ''
  ];
}
