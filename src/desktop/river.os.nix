{ pkgs, lib, ... }: {
  programs.river = {
    enable = true;
    extraPackages = [ ];
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_RENDERER = "vulkan";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    # MOZ_USE_XINPUT2 = "1";
    # XWAYLAND_NO_GLAMOR = "1";
  };
}
