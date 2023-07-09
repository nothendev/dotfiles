{ lib, config, pkgs, ... }:

{
  home.file.".config/doom" = {
    enable = true;
    source = ../configs/doom;
  };
}
