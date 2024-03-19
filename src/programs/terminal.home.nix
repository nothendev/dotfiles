{ pkgs, system, fjo, zjstatus, osConfig, ... }: {
  home.packages = with pkgs; [
    fish # superior shell
    starship # superior shell prompt
    evcxr # rust repl
    colmena # le deploy
    fd # find find find find
    fzf # fuzzy finder
    zoxide # z
    eza # ls blazing fast
    ranger # explorer but command line
    bat # pager blazing fast
    pandoc # document convertator
    cachix
    nixfmt
    # fjo.packages.${system}.default # THE forgejo tool
    xdg-utils # ???
  ];
  home.sessionVariables.PAGER = "bat";
  programs.alacritty.enable = true;
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = { theme = "catppuccin-mocha"; };
  };
  xdg.configFile."zellij/layouts/default.kdl".text =
    with pkgs.lib.mapAttrs (_: hex: "#${hex}") osConfig.pretty.base69;
    let
      basebg =
        "0"; # alias for ease of readability, allows for background blur; ansi default bg color (magic value...)
      # ribbon color: from bg to bgn
      ribbon = text: main: bg: bgn:
        "#[bg=${main},fg=${bg}] ${text} #[fg=${main},bg=${bgn}]";
      ribbon' = text: main: bg: bgn: textAttr:
        "#[bg=${main},fg=${bg},${textAttr}] ${text} #[fg=${main},bg=${bgn}]";
      # ribbon color: from bgn to bg (reverse order because left)
      lribbon = text: main: bg: bgn:
        "#[fg=${main},bg=${bgn}]#[bg=${main},fg=${bg}] ${text} ";
      lribbon' = text: main: bg: bgn: textAttr:
        "#[fg=${main},bg=${bgn}]#[bg=${main},fg=${bg},${textAttr}] ${text} ";
    in ''
      layout {
          default_tab_template name="tab" {
              pane size=1 borderless=true {
                  plugin location="file:${
                    zjstatus.packages.${system}.default
                  }/bin/zjstatus.wasm" {
                      format_left   "#[fg=${base}]{mode}#[bg=${lavender},fg=${base},bold] {session} #[fg=${lavender},bg=${sapphire}]${
                        ribbon "{swap_layout}" sapphire base basebg
                      }"
                      format_center "{tabs}"
                      format_right  "${
                        lribbon "{command_git_branch}" blue base basebg
                      }${lribbon' "{datetime}" teal base blue "bold"}"
                      format_space  ""

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=${base}]{char}"
                      border_position "top"

                      hide_frame_for_single_pane "true"

                      mode_normal "${
                        ribbon' "NORMAL" blue base lavender "bold"
                      }"
                      mode_locked "${ribbon' "LOCKED" red base lavender "bold"}"
                      mode_pane   "${
                        ribbon' "PANE" flamingo base lavender "bold"
                      }"
                      mode_tab    "${ribbon' "TAB" sky base lavender "bold"}"
                      mode_scroll "${
                        ribbon' "SCROLL" mauve base lavender "bold"
                      }"
                      mode_search "${
                        ribbon' "SEARCH" maroon base lavender "bold"
                      }"
                      mode_session "${
                        ribbon' "SESSION" sapphire base lavender "bold"
                      }"
                      mode_tmux   "${ribbon' "TMUX" peach base lavender "bold"}"

                      tab_normal   " {name} "
                      tab_active   " ${
                        ribbon' "{name}" green base base "bold,italic"
                      } "

                      command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                      command_git_branch_format      "{stdout}"
                      command_git_branch_interval    "10"
                      command_git_branch_rendermode  "static"

                      datetime        "{format}"
                      datetime_format "%A, %d %b %Y %H:%M:%S"
                      datetime_timezone "Europe/Moscow"
                  }
              }
              children
          }
          swap_tiled_layout name="vertical" {
              tab max_panes=5 {
                  pane split_direction="vertical" {
                      pane
                      pane { children; }
                  }
              }
              tab max_panes=8 {
                  pane split_direction="vertical" {
                      pane { children; }
                      pane { pane; pane; pane; pane; }
                  }
              }
              tab max_panes=12 {
                  pane split_direction="vertical" {
                      pane { children; }
                      pane { pane; pane; pane; pane; }
                      pane { pane; pane; pane; pane; }
                  }
              }
          }

          swap_tiled_layout name="horizontal" {
              tab max_panes=5 {
                  pane
                  pane
              }
              tab max_panes=8 {
                  pane {
                      pane split_direction="vertical" { children; }
                      pane split_direction="vertical" { pane; pane; pane; pane; }
                  }
              }
              tab max_panes=12 {
                  pane {
                      pane split_direction="vertical" { children; }
                      pane split_direction="vertical" { pane; pane; pane; pane; }
                      pane split_direction="vertical" { pane; pane; pane; pane; }
                  }
              }
          }

          swap_tiled_layout name="stacked" {
              tab min_panes=5 {
                  pane split_direction="vertical" {
                      pane
                      pane stacked=true { children; }
                  }
              }
          }

          swap_floating_layout name="staggered" {
              floating_panes
          }

          swap_floating_layout name="enlarged" {
              floating_panes max_panes=10 {
                  pane { x "5%"; y 1; width "90%"; height "90%"; }
                  pane { x "5%"; y 2; width "90%"; height "90%"; }
                  pane { x "5%"; y 3; width "90%"; height "90%"; }
                  pane { x "5%"; y 4; width "90%"; height "90%"; }
                  pane { x "5%"; y 5; width "90%"; height "90%"; }
                  pane { x "5%"; y 6; width "90%"; height "90%"; }
                  pane { x "5%"; y 7; width "90%"; height "90%"; }
                  pane { x "5%"; y 8; width "90%"; height "90%"; }
                  pane { x "5%"; y 9; width "90%"; height "90%"; }
                  pane focus=true { x 10; y 10; width "90%"; height "90%"; }
              }
          }

          swap_floating_layout name="spread" {
              floating_panes max_panes=1 {
                  pane {y "50%"; x "50%"; }
              }
              floating_panes max_panes=2 {
                  pane { x "1%"; y "25%"; width "45%"; }
                  pane { x "50%"; y "25%"; width "45%"; }
              }
              floating_panes max_panes=3 {
                  pane focus=true { y "55%"; width "45%"; height "45%"; }
                  pane { x "1%"; y "1%"; width "45%"; }
                  pane { x "50%"; y "1%"; width "45%"; }
              }
              floating_panes max_panes=4 {
                  pane { x "1%"; y "55%"; width "45%"; height "45%"; }
                  pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
                  pane { x "1%"; y "1%"; width "45%"; height "45%"; }
                  pane { x "50%"; y "1%"; width "45%"; height "45%"; }
              }
          }
      }
    '';
}
