{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    ncmpcpp
    rmpc
  ];
}
