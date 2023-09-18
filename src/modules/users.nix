{ config, pkgs, ... }:
{
  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "networkmanager" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;
  users.users.root = { initialHashedPassword = ""; };
}
