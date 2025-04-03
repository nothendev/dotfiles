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
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";
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
        sed -i -e "s/%%THEME%%/mocha/g" $them/metadata.desktop

        cp ${catppuccin-sddm}/pertheme/${flavor}.png $them/preview.png
        cp ${catppuccin-sddm}/pertheme/${flavor}.conf $them/theme.conf
      ''
    )
  ];
  # FUCK pulseaudio!
  services.pulseaudio.enable = false;
}
