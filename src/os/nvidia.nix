{
  config,
  pkgs,
  catppuccin-sddm,
  ...
}:
{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  nixpkgs.config.allowUnfree = true;
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
    displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      autoNumlock = true;
      theme = "catppuccin-mocha";
    };
    displayManager.lightdm.enable = false;
    displayManager.autoLogin = {
      enable = false;
      user = "ilya";
    };
    libinput = {
      enable = true;
      # mouse.additionalOptions =
      #   ''
      #     Option "ModelBouncingKeys" 1
      #   ''
      # ;
    };
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
  hardware.pulseaudio.enable = false;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    nvidiaSettings = true;
  };
}
