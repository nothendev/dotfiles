{ config, pkgs, ... }: {
  imports = [ ../common/base69/themes/catppuccin.nix ];
  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" "ComicShannsMono" ]; })
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
  hardware.opentabletdriver.daemon.enable = true;
  systemd.user.services.opentabletdriver.enable = true;
  pretty.catppuccin = {
    enable = true;
    flavour = "mocha";
  };
  pretty.font = {
    family = "JetBrainsMono Nerd Font";
    defaultSize = 13;
  };
}
