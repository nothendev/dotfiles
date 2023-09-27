{ config, pkgs, osConfig, ... }:

let
  makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in
{
  home.file =
    # Doom Emacs
    makeCfg "doom" //
    # Hyprpaper (Hyprland wallpaper utility)
    makeCfg "hypr/hyprpaper.conf";

  home.file.".config/doom/base69.el".text = with pkgs.lib; ''
    (setq base69-colors '(${lib.concatStrings (attrsets.mapAttrsToList (name: value: "(${name} \"#${value}\")") (attrsets.filterAttrs (name: value: name != "theme") osConfig.base69))}))
  '';
}
