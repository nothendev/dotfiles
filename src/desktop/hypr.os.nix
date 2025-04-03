{
  config,
  pkgs,
  hyprland,
  ...
}:
let
  hyprpkgs = hyprland.packages."x86_64-linux";
  hypr-nixpkgs = hyprland.inputs.nixpkgs.legacyPackages."x86_64-linux";
  fpp = config.programs.hyprland.portalPackage.override { hyprland = config.programs.hyprland.package; };
in
{
  hardware.graphics.package = hypr-nixpkgs.mesa.drivers;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprpkgs.hyprland;
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
  environment.systemPackages = [ config.programs.hyprland.package ];

  xdg.portal = {
    enable = true;
    config.common = {
      default = "*";
    };
    config.hyprland = {
      default = "*";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      fpp
    ];
    xdgOpenUsePortal = false;
    configPackages = [ config.programs.hyprland.package ];
    wlr.enable = pkgs.lib.mkForce false;
  };
}
