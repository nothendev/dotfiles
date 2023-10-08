{ config, pkgs, hyprportalpkgs, ... }:
let hyprpkgs = hyprportalpkgs.legacyPackages."x86_64-linux";
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
    enableNvidiaPatches = true;
  };
  environment.systemPackages = [
    hyprpkgs.xdg-desktop-portal-hyprland
    config.programs.hyprland.finalPackage
  ];
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.xserver.displayManager.sessionPackages = [ config.programs.hyprland.finalPackage ];
  xdg.portal = {
    enable = true;
    extraPortals = [ hyprpkgs.xdg-desktop-portal-hyprland ];
  };
}
