{ config, pkgs, ... }:

let
  makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in
{
  home.files = makeCfg "doom" // makeCfg "eww";
}
