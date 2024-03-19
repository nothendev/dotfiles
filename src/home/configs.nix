{ config, pkgs, osConfig, ... }:

let makeCfg = path: { ".config/${path}".source = ../configs/${path}; };
in {
  home.file = {
    # ".gitconfig".text = ''
    #   [user]
    #       name = Borodinov Ilya
    #       email = borodinov.ilya@gmail.com
    #   [diff]
    #       tool = kitty
    #       guitool = kitty.gui
    #   [difftool]
    #       prompt = false
    #       trustExitCode = true
    #   [difftool "kitty"]
    #       cmd = kitten diff $LOCAL $REMOTE
    #   [difftool "kitty.gui"]
    #       cmd = kitten diff $LOCAL $REMOTE
    # '';
  };
}
