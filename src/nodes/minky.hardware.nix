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
    "ahci"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "sdhci_acpi"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.logind.lidSwitch = "ignore";
  services.logind.extraConfig = "HandleLidSwitch=ignore";

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/82740a13-d282-4a09-a7cf-1ab6fc353c65";
    fsType = "ext4";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/befbf43c-4e67-4deb-8881-f7f8bd78f77b"; } ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
  networking.firewall.enable = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
