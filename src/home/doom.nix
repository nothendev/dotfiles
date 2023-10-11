{ nix-doom-emacs, pkgs, ... }:
{
  imports = [ nix-doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ../configs/doom;
    doomPackageDir = pkgs.linkFarm "noth-doom-straight-env" [
      # straight needs a (possibly empty) `config.el` file to build
      {
        name = "config.el";
        path = pkgs.emptyFile;
      }
      { name = "init.el"; path = ../configs/doom/init.el; }
      { name = "packages.el"; path = ../configs/doom/packages.el; }
      { name = "modules"; path = ../configs/doom/modules; }
    ];
  };

  home.sessionVariables.EDITOR = "emacs";
}
