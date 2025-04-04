{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.blacklistedKernelModules = [
    "wacom"
    "hid_uclogic"
  ];
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
}
