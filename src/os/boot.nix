{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_6_6;
  boot.kernelParams = [ "usbhid.mousepoll=4" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
}
