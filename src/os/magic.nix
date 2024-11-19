{
  config,
  pkgs,
  lib,
  ...
}:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "ilya"
    ];
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };
  nixpkgs.config.permittedInsecurePackages = [ "nix-2.15.3" ];
  services.printing = {
    enable = false;
    drivers = with pkgs; [ canon-cups-updated ];
  };
  services.gnome.gnome-keyring.enable = true;
  # pam_gnome_keyring for some reason FUCKING breaks the entire sddm login process...
  security.pam.services.login.enableGnomeKeyring = lib.mkForce false;
  programs.seahorse.enable = true;
  programs.dconf.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
