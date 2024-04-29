{
  config,
  pkgs,
  hyprland,
  ...
}:
let
  hyprpkgs = hyprland.packages."x86_64-linux";
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
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = [ config.programs.hyprland.finalPackage ];
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.xserver.displayManager.sessionPackages = [ config.programs.hyprland.finalPackage ];
  xdg.portal = {
    enable = true;
    extraPortals = pkgs.lib.mkForce [
      config.programs.hyprland.portalPackage
      pkgs.xdg-desktop-portal-gtk
    ];
    wlr.enable = pkgs.lib.mkForce false;
  };
}
