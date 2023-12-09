{ config, pkgs }: {
  programs.firefox = {
    enable = true;
    profiles.explodus = {
      isDefault = true;
      name = "explodus";
      extraConfig = ./user.js;
    };
  };
}
