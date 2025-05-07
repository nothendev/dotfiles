{
  pkgs,
  ...
}:
{
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = (
    pkgs.lib.mkOrder 100 ''
      fish_default_key_bindings
      fish_config theme choose fish\ default
      ${pkgs.zoxide}/bin/zoxide init fish --cmd j | source
      set ZELLIJ_AUTO_ATTACH true
    ''
  );
  programs.fish.functions = {
    stfd = "sudo shutdown --no-wall 0";
  };
  programs.fish.shellAliases = {
    l = "eza -l --icons";
    ls = "eza --icons";
    cp = "rsync -P";
    zcp = "rsync --info=progress2 -auvz";
    k = "kubectl";
  };
  programs.fish.shellInit = ''
    function fish_mode_prompt
    end
    function fish_prompt
        printf '%s%s%s> %s' (set_color facc15) (prompt_pwd) (set_color brred -o) (set_color normal)
    end
    set -gx PATH $HOME/.cache/.bun/bin $HOME/.bun/bin $HOME/go/bin $HOME/.cargo/bin $PATH
  '';
  programs.direnv.enable = true;
}
