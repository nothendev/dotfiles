{ config, pkgs, ... }:
{
  imports = [ ../common/base69/themes/catppuccin.nix ];
  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "ComicShannsMono"
      ];
    })
    font-awesome
    monocraft
    miracode
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
  hardware.opentabletdriver.enable = false;
  hardware.opentabletdriver.daemon.enable = false;
  systemd.user.services.opentabletdriver.enable = false;
  pretty.catppuccin = {
    enable = true;
    flavour = "mocha";
  };
  pretty.font = {
    family = "Monocraft Nerd Font";
    defaultSize = 13;
  };
}
