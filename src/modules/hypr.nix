{ config, pkgs, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };
  environment.systemPackages = [
    (config.programs.hyprland.portalPackage.override { hyprland = config.programs.hyprland.finalPackage; })
  ];
}
