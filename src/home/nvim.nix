{ pkgs, nixvim }:
{
  imports = [ nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lightline.enable = true;
  };
  home.packages = with pkgs; [ neovide ];
}
