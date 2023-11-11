{ nix-doom-emacs, pkgs, ammonite-term-repl, ... }:
{
  imports = [ nix-doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    # emacsPackage = pkgs.emacs28-pgtk;
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
    emacsPackagesOverlay = self: super: {
      ammonite-term-repl = self.trivialBuild {
        pname = "ammonite-term-repl";
        ename = "ammonite-term-repl";
        version = "0.2";
        buildInputs = [ pkgs.ammonite self.scala-mode self.s ];
        src = ammonite-term-repl;
      };
      ob-ammonite = self.trivialBuild {
        pname = "ob-ammonite";
        ename = "ob-ammonite";
        version = "0.2";
        buildInputs = [ self.ammonite-term-repl self.scala-mode self.s self.xterm-color ];
        src = nix-doom-emacs.inputs.ob-ammonite;
      };
    };
  };

  home.sessionVariables.EDITOR = "emacs";
}
