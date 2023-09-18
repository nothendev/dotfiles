{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.pretty.catppuccin;
  flavour = cfg.flavour;
  flavours = import ./flavours.nix;
in
{
  options.pretty.catppuccin = {
    enable = mkEnableOption "Enable catppuccin for base69";
    flavour = mkOption {
      type = with types; enum [ "mocha" "macchiato" "frappe" "latte" ];
      default = "mocha";
      description = lib.mdDoc ''
        The Catppuccin flavor to apply to base69.
      '';
    };
  };

  config.pretty.base69 = lib.mkIf cfg.enable flavours."${flavour}";
}
