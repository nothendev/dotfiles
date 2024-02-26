{ config, pkgs, ... }: {
  imports = [ ../common/base69/themes/github-dark.nix ];
  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    rubik
    inter
    ubuntu_font_family
    corefonts
    source-sans
    source-code-pro
    noto-fonts
  ];
  fonts.fontDir.enable = true;
  programs.fish.enable = true;
  hardware.opentabletdriver.enable = true;
  # pretty.catppuccin = {
  #   enable = true;
  #   flavour = "oled";
  # };
}