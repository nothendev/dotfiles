{ config, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "ilya" ];
  };
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ canon-cups-ufr2 ];
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  environment.systemPackages = with pkgs; [ gcr ];
}
