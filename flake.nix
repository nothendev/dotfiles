{
  inputs = {
    ## Nixpkgs and Home-manager
    #nixpkgs.follows = "nixvim/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ## LE FLAKE PARTS (I LOVE FLAKE PARTS I LOVE FLAKE PARTS I LOVE FLAKE PARTS I LOVE FLAKE PARTS)
    fp.url = "github:hercules-ci/flake-parts";
    deploy.url = "github:serokell/deploy-rs";

    ## Prog langs
    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";
    zls.url = "github:zigtools/zls";
    zls.inputs.nixpkgs.follows = "nixpkgs";
    zls.inputs.zig-overlay.follows = "zig";

    ## Wayland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #hyprland.follows = "hyprland-plugins/hyprland";
    nixwaypkgs.url = "github:nix-community/nixpkgs-wayland";
    nixwaypkgs.inputs.nixpkgs.follows = "nixpkgs";
    #hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    #hyprland-plugins.inputs.hyprland.follows = "hyprland";

    ## Nvim
    nixvim.url = "github:nix-community/nixvim";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    ## Terminal
    fjo.url = "git+https://codeberg.org/VoiDD/fjo";
    fjo.inputs.nixpkgs.follows = "nixpkgs";
    zjstatus.url = "github:dj95/zjstatus";

    ## Mattermost
    mattermost-plugin-focalboard.url =
      "file+https://github.com/mattermost/focalboard/releases/download/v7.10.6/mattermost-plugin-focalboard.tar.gz";
    mattermost-plugin-focalboard.flake = false;
    mattermost-plugin-jitsi.url =
      "file+https://github.com/mattermost/mattermost-plugin-jitsi/releases/download/v2.0.1/jitsi-2.0.1.tar.gz";
    mattermost-plugin-jitsi.flake = false;

    ## Catppuccin
    catppuccin-alacritty.url = "github:catppuccin/alacritty";
    catppuccin-alacritty.flake = false;

    catppuccin-starship.url = "github:catppuccin/starship";
    catppuccin-starship.flake = false;

    catppuccin-fish.url = "github:catppuccin/fish";
    catppuccin-fish.flake = false;

    catppuccin-sddm.url = "github:catppuccin/sddm";
    catppuccin-sddm.flake = false;
  };

  outputs = { fp, ... }@inputs:
    fp.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./src/systems ./src/nodes ];
      perSystem = { self', pkgs, ... }: {
        packages.wings = pkgs.callPackage ./src/pkgs/wings.nix {};
        formatter = pkgs.nixfmt-rfc-style;
        apps.wings = {
          type = "app";
          program = "${self'.packages.wings}/bin/wings";
        };
      };
    };
}
