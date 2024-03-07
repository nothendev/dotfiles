{ config, pkgs, fjo, system, osConfig, zjstatus, ... }:
{
  home.packages = with pkgs; [
    fzf
    zoxide
    qpwgraph
    eza
    pandoc
    session-desktop
    fd
    mpv
    anytype
    blender
    # firefox
    ## broken btabld
    kotatogram-desktop
    fjo.packages.${system}.default
    evcxr
    colmena
    # telegram-desktop
    xdg-utils
    grim
    slurp
    wl-clipboard
    hyprpicker
    hyprpaper
    watershot
    pavucontrol
    playerctl
    wev
    librewolf
    cachix
    rnix-lsp
    nixfmt
    prismlauncher
    qbittorrent
    ranger
    steam
    canon-cups-ufr2

    libreoffice-fresh
    gimp
    # krita
    inkscape
    gnome.nautilus
    # wineWowPackages.waylandFull
    # glfw-minecraft
    glfw
    # blender
    # obsidian
    mangohud
    # I HATE NVIDIA I HATE NVIDIA I HATE NVIDIA
    (vesktop.overrideAttrs
      (a: { desktopItems = map (d: d.override { exec = "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland vesktop --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing %u"; }) a.desktopItems; }))
    (element-desktop.overrideAttrs
      (e: rec {
        # Add arguments to the .desktop entry
        desktopItem = e.desktopItem.override (d: {
          exec = "env NIXOS_OZONE_WL=1 element-desktop --disable-gpu-compositing %u";
        });

        # Update the install script to use the new .desktop entry
        installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
      }))
    zellij
  ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };
  xdg.configFile."zellij/layouts/default.kdl".text =
    let
      base69 = osConfig.pretty.base69;
      # ribbon color: from bg to bgn
      ribbon = text: main: bg: bgn: "#[bg=#${base69.${main}},fg=#${base69.${bg}}] ${text} #[fg=#${base69.${main}},bg=#${base69.${bgn}}]";
      ribbon' = text: main: bg: bgn: textAttr: "#[bg=#${base69.${main}},fg=#${base69.${bg}},${textAttr}] ${text} #[fg=#${base69.${main}},bg=#${base69.${bgn}}]";
      # ribbon color: from bgn to bg (reverse order because left)
      lribbon = text: main: bg: bgn: "#[fg=#${base69.${main}},bg=#${base69.${bgn}}]#[bg=#${base69.${main}},fg=#${base69.${bg}}] ${text} ";
      lribbon' = text: main: bg: bgn: textAttr: "#[fg=#${base69.${main}},bg=#${base69.${bgn}}]#[bg=#${base69.${main}},fg=#${base69.${bg}},${textAttr}] ${text} ";
    in
    ''
      layout {
          default_tab_template name="tab" {
              pane size=1 borderless=true {
                  plugin location="file:${zjstatus.packages.${system}.default}/bin/zjstatus.wasm" {
                      format_left   "#[fg=#${base69.base}]{mode}#[fg=#${base69.base},bg=#${base69.lavender},bold] {session} #[fg=#${base69.lavender},bg=#${base69.base}]"
                      format_center "{tabs}"
                      format_right  "${lribbon "{command_git_branch}" "blue" "base" "base"}${lribbon' "{datetime}" "teal" "base" "blue" "bold"}"
                      format_space  ""

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=#${base69.base}]{char}"
                      border_position "top"

                      hide_frame_for_single_pane "true"

                      mode_normal  "${ribbon' "NORMAL" "blue" "base" "lavender" "bold"}"
                      mode_tmux    "${ribbon' "TMUX" "peach" "base" "lavender" "bold"}"

                      tab_normal   " {name} "
                      tab_active   " ${ribbon' "{name}" "green" "base" "base" "bold,italic"} "

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
