{ lib, ... }: {
  options.deployment = {
    targetHost = lib.mkOption {
      type = lib.types.str;
    };
    targetUser = lib.mkOption {
      type = lib.types.str;
      default = "root";
    };
  };
}
