{ config, lib, pkgs, ... }:

let
  mkColor = name:
    lib.mkOption {
      type = with lib.types; str;
      description = lib.mdDoc "The ${name} color in hex.";
    };
  colors = lib.attrsets.genAttrs ([
    "rosewater"
    "flamingo"
    "pink"
    "mauve"
    "red"
    "maroon"
    "peach"
    "yellow"
    "green"
    "teal"
    "sky"
    "sapphire"
    "blue"
    "lavender"
    "text"
    "subtext1"
    "subtext0"
    "overlay2"
    "overlay1"
    "overlay0"
    "surface2"
    "surface1"
    "surface0"
    "base"
    "mantle"
    "crust"
  ]) (name: mkColor name);
in {
  options.pretty.base69 = colors;
  options.pretty.font = {
    family = lib.mkOption {
      type = lib.types.str;
      description = lib.mdDoc "The font used all around the system";
    };
    defaultSize = lib.mkOption {
      type = lib.types.int;
      description = lib.mdDoc "The default font size";
    };
  };
}
