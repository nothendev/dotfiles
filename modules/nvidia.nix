{ config, pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    libinput.enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
