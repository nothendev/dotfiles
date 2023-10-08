{ config, pkgs, osConfig, ... }:

let
  makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in
{
  home.file = {
    # Doom Emacs
    ".config/doom" = let base69el = pkgs.writeText "base69.el" (
      with pkgs.lib; ''
        (setq base69-colors '(${concatStrings (attrsets.mapAttrsToList (name: value: "(${name} . \"#${value}\")") osConfig.pretty.base69)}))
      ''
    ); in
      {
        source = pkgs.runCommand "build-doom" { } ''
          mkdir $out
          ln -s ${../configs/doom}/* $out/
          ln -s ${base69el} $out/base69.el
        '';
      };
  };
}
