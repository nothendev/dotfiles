{ config, pkgs, ... }: {
  programs.fish.enable = true;
  home.file.".config/fish/themes".source = (pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "91e6d6721362be05a5c62e235ed8517d90c567c9";
    sha256 = "sha256-l9V7YMfJWhKDL65dNbxaddhaM6GJ0CFZ6z+4R6MJwBA=";
  }) + "/themes";
  programs.fish.functions = {
    l = ''
      eza -1amFhl --icons $argv
    '';
  };
  programs.direnv.enable = true;
}
