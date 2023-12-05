{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
}
