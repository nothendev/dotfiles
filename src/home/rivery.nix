{ config, lib, pkgs, ... }: {
  options.wayland.windowManager.river = {
    enable = lib.mkEnableOption "River wayland compositor";
    
    init = {
      map = lib.mkOption {
        type = with lib.types; attrsOf (listOf str);
        description = "Mappings. Is an attribute set of `mode_name = [ mapping1 mapping2 ]`";
      };
      background-color = lib.mkOption {
        type = with lib.types; str;
        description = "Background color";
      };
    };
  };
}
