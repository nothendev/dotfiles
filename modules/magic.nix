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
}
