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
    displayManager.autoLogin = {
      enable = true;
      user = "ilya";
    };
    libinput = {
      enable = true;
      # mouse.additionalOptions =
      #   ''
      #     Option "ModelBouncingKeys" 1
      #   ''
      # ;
    };
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    nvidiaSettings = true;
  };
}
