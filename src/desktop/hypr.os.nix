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
    jack.enable = true;
  };
  hardware.graphics.package = hypr-nixpkgs.mesa.drivers;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprpkgs.hyprland;
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
  };
  # for home-manager xdg-desktop
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  environment.systemPackages = [ config.programs.hyprland.package ];
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.displayManager.sessionPackages = [ config.programs.hyprland.package ];
  services.dbus.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
