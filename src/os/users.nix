{ config, pkgs, ... }: {
  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "networkmanager" "wireshark" ];
    shell = pkgs.fish;
  };
  security.sudo.wheelNeedsPassword = false;
  users.users.root = { initialHashedPassword = ""; };
}
