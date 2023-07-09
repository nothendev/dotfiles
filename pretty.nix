{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    jetbrains-mono
    monocraft
    (nerdfonts.override { fonts = [ "JetBrainsMono"]; })
    font-awesome
  ];
}
