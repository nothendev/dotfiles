{ config, pkgs, hyprland, ... }:
let hyprpkgs = hyprland.packages."x86_64-linux";
in {
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
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland.override {
      hyprland = config.programs.hyprland.finalPackage;
    };
  };
  environment.systemPackages = [ config.programs.hyprland.finalPackage ];
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.xserver.displayManager.sessionPackages =
    [ config.programs.hyprland.finalPackage ];
  xdg.portal = {
    enable = true;
    extraPortals = pkgs.lib.mkForce [
      pkgs.xdg-desktop-portal-gtk
      config.programs.hyprland.portalPackage
    ];
    configPackages = [ config.programs.hyprland.finalPackage ];
    wlr.enable = pkgs.lib.mkForce false;
  };
}
