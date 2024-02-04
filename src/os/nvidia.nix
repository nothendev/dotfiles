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
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
    };
    displayManager.lightdm.enable = false;
    displayManager.autoLogin = {
      enable = false;
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
  hardware.pulseaudio.enable = false;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    nvidiaSettings = true;
  };
}
