{ pkgs, lib, ... }: {
  programs.river = { enable = true; extraPackages = []; };
}
