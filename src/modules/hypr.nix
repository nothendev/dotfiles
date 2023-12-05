{ config, pkgs, hyprland, ... }:
let hyprpkgs = hyprland.packages."x86_64-linux";
in
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.hyprland = {
    xwayland.enable = true;
    package = hyprpkgs.hyprland;
  };
  environment.systemPackages = [
    config.programs.hyprland.finalPackage
  ];
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.xserver.displayManager.sessionPackages =
    [ config.programs.hyprland.finalPackage ];
  xdg.portal = {
    enable = true;
    extraPortals = [
      hyprpkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
