{ config, pkgs, ... }:

let
  makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in
{
  home.file = makeCfg "doom" // makeCfg "eww";
}
