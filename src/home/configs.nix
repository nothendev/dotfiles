{ config, pkgs, ... }:

let
  makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in
{
  home.file =
    # Doom Emacs
    makeCfg "doom" //
    # Hyprpaper (Hyprland wallpaper utility)
    makeCfg "hypr/hyprpaper.conf";
}
