{ config, pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    monocraft
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    rubik
    inter
    ubuntu_font_family
  ];
  # programs.starship = { enable = true; };
  programs.fish.enable = true;
  hardware.opentabletdriver.enable = true;
}
