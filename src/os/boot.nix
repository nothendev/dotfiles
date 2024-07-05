{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelParams = [
    #"video=Unknown-1:d"
    "nvidia-drm.fbdev=1"
    "nvidia_drm.fbdev=1"
  ];
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
}
