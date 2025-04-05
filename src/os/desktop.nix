{ pkgs, catppuccin-sddm, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  security.polkit.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    config.common = {
      default = "*";
    };
    config.hyprland = {
      default = "*";
    };
    config.kde = {
      default = "*";
    };
  };
  environment.etc."xdg-desktop-portal".source = "/etc/xdg/xdg-desktop-portal";
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";
  };
  systemd.user.services.xdg-desktop-portal.environment = {
    NIX_XDG_DESKTOP_PORTAL_DIR = pkgs.lib.mkForce "/run/current-system/sw/share/xdg-desktop-portal/portals";
  };

  # SDDM
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
      theme = "catppuccin-mocha";
    };
    autoLogin = {
      enable = false;
      user = "ilya";
    };
  };
  services.libinput = {
    enable = true;
    mouse.additionalOptions = ''
      Option "ModelBouncingKeys" 1
    '';
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
  };
  environment.systemPackages = [
    (
      let
        flavor = "mocha";
      in
      pkgs.runCommand "sddm-catppuccin" { } ''
        them=$out/share/sddm/themes/catppuccin-${flavor}
        mkdir -p $them
        cp -r ${catppuccin-sddm}/src/* $them/
        sed -i -e "s/%%THEME%%/${flavor}/g" $them/metadata.desktop

        cp ${catppuccin-sddm}/pertheme/${flavor}.png $them/preview.png
        cp ${catppuccin-sddm}/pertheme/${flavor}.conf $them/theme.conf
      ''
    )
    (
      pkgs.runCommand "usr-share-xdp-sway" {} ''
        o=$out/share/xdg-desktop-portal
        mkdir -p $o
        ln -s ${pkgs.writeText "sway-portals.conf" ''
        [preferred]
        default=gtk
        org.freedesktop.impl.portal.Inhibit=none
        org.freedesktop.impl.portal.ScreenCast=wlr
        org.freedesktop.impl.portal.Screenshot=wlr
        ''} $o/sway-portals.conf
      ''
    )
  ];
  # FUCK pulseaudio!
  services.pulseaudio.enable = false;
}
