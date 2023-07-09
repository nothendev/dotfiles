{ config, pkgs, ... }:

let
  makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in
{
  home.file =
    # Doom Emacs
    makeCfg "doom" //
    # ElKowars wacky widgets (eww)
    makeCfg "eww" //
    # Hyprland
    makeCfg "hypr";
}
