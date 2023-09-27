{ config, pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    monocraft
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    rubik
    inter
    ubuntu_font_family
    corefonts
  ];
  programs.fish.enable = true;
  hardware.opentabletdriver.enable = true;
  # pretty.catppuccin = {
  #   enable = true;
  #   flavour = "oled";
  # };
  pretty.base69.theme = "github-dark";
}
