{ config, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "ilya" ];
  };
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
