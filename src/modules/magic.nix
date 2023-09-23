{ config, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "ilya" ];
    trusted-substituters = [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
    substituters = [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ canon-cups-ufr2 ];
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  # services.gnome.gnome-keyring.enable = true;
  # programs.seahorse.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ gcr ];
}
