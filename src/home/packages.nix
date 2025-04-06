{
  zig,
  pkgs,
  system,
  self,
  ...
}:
{
  services.syncthing.enable = true;
  home.packages =
    (with pkgs; [
      self.packages.${system}.winbox
      self.packages.${system}.bxt-launcher
      #self.packages.${system}.zen-browser
      #self.packages.${system}.redot

      ## Console utilities
      service-wrapper # `service SOMETHING start/stop/*`
      imagemagick
      hyperfine
      file
      bun
      unixtools.xxd
      unrar
      grim # Screenshot
      slurp # Select area for screenshot
      wl-clipboard # wl-copy/wl-paste

      ## Just the one fucking time I had to install Windows 10 from uupdump.
      aria2
      cabextract
      wimlib
      chntpw
      cdrkit

      ## CAS - CONTAINERS AND SHIT
      kompose
      kustomize
      kubectl
      kubernetes-helm
      fluxcd
      kind
      istioctl

      ## Graphical
      ghidra-bin
      freecad
      jetbrains.idea-community-src
      code-cursor
      ghostty
      imhex
      thunderbird-128
      wlr-randr
      qpwgraph
      mpv
      blockbench
      hyprpicker
      pavucontrol
      playerctl
      wev
      librewolf
      (brave.overrideAttrs (old: {
        postInstall = ''
          substituteInPlace $out/share/applications/brave-browser.desktop \
            --replace "$out/bin/brave" "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland $out/bin/brave --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing"
        '';
      }))
      qbittorrent
      lutris
      (bottles.override { removeWarningPopup = true; })
      ida-free
      anydesk
      d-spy
      (cutter.withPlugins (
        ps: with ps; [
          rz-ghidra
          jsdec
          sigdb
        ]
      ))

      ## Gaming
      prismlauncher
      mangohud
      steam
      r2modman

      ## Art
      tenacity
      libreoffice-fresh # the dreaded
      gimp # my beloved
      krita
      inkscape
      blender
      kdePackages.kdenlive

      ## Communication (messengers)
      (legcord.overrideAttrs (a: {
        desktopItems = map (
          d:
          d.override {
            exec = "env NIXOS_OZONE_WL=1 GDK_BACKEND=wayland legcord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --disable-gpu-compositing %u";
          }
        ) a.desktopItems;
      }))
      (element-desktop.overrideAttrs (e: rec {
        # Add arguments to the .desktop entry
        desktopItem = e.desktopItem.override (d: {
          exec = "env NIXOS_OZONE_WL=1 element-desktop --disable-gpu-compositing %u";
        });

        # Update the install script to use the new .desktop entry
        installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
      }))
    ])
    ++ (with pkgs.libsForQt5; [
      okular
      ark
      dolphin
    ])
    ++ [
      zig.packages.${system}.master
    ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-freeze-filter
    ];
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
