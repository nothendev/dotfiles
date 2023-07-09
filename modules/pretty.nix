{ config, pkgs, ... }: {
  fonts.fonts = with pkgs; [
    jetbrains-mono
    monocraft
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
  ];
  programs.starship = { enable = true; };
  programs.fish.enable = true;
}
