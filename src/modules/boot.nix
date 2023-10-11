{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = true;
  };
}
