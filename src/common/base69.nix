{ config, lib, pkgs, ... }:

let mkColor = name: {
  hex = lib.mkOption { type = lib.types.str; description = lib.mdDoc "the hexadecimal value for the ${name} color"; };
  rgb = lib.mkOption { type = lib.types.str; description = lib.mdDoc "the RGB function (CSS) value for the ${name} color"; };
  hsl = lib.mkOption { type = lib.types.str; description = lib.mdDoc "the HSL function (CSS) value for the ${name} color"; };
  raw = lib.mkOption { type = lib.types.str; description = lib.mdDoc "the raw value (without `css()`) for the ${name} color"; };
};
in
{
  options.pretty.base69 = lib.attrsets.genAttrs
    ([
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
    ])
    (name: mkColor name);
}
