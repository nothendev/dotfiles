{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b79755bc-e016-4806-aa9c-4324c8bf2783";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0BDC-3858";
    fsType = "vfat";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/B24A-F71C";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/archlinux-home";
    fsType = "ext4";
  };

  fileSystems."/mnt/k" = {
    device = "/dev/disk/by-label/coding";
    fsType = "ext4";
  };

  fileSystems."/mnt/s" = {
    device = "/dev/disk/by-uuid/12318b76-64e0-4b98-aa6d-6617346c70ca";
    fsType = "ext4";
  };

  # fileSystems."/void" = {
  #   device = "/dev/disk/by-label/void";
  #   fsType = "ext4";
  # };

  swapDevices = [
    {
      label = "funnyswap";
    }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
