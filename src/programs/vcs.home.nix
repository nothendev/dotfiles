{ pkgs, ... }:
{
  programs.mercurial = {
    enable = true;
    extraConfig.extensions.convert = "";
    package = pkgs.mercurialFull;
    userEmail = "borodinov.ilya@gmail.com";
    userName = "noth";
  };
}
