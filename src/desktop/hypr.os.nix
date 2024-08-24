{
  config,
  pkgs,
  hyprland,
  ...
}:
let
  hyprpkgs = hyprland.packages."x86_64-linux";
  hypr-nixpkgs = hyprland.inputs.nixpkgs.legacyPackages."x86_64-linux";
in
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  #hardware.opengl.package = hypr-nixpkgs.mesa.drivers;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    #package = hyprpkgs.hyprland;
    #portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = [ config.programs.hyprland.package ];
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.xserver.displayManager.sessionPackages = [ config.programs.hyprland.package ];

  xdg.portal = {
    enable = true;

    config.preferred = {
      default = [ "*" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      config.programs.hyprland.portalPackage
    ];
    configPackages = [ config.programs.hyprland.package ];
    wlr.enable = pkgs.lib.mkForce false;
  };
}
