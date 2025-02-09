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
    treefmt-nix.url = "github:numtide/treefmt-nix";

    ## Prog langs
    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";
    zls.url = "github:zigtools/zls";
    zls.inputs.nixpkgs.follows = "nixpkgs";
    zls.inputs.zig-overlay.follows = "zig";

    ## Wayland
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=4520b30d498daca8079365bdb909a8dea38e8d55";
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

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.nixos.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  outputs =
    { fp, ... }@inputs:
    fp.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./src/systems
        ./src/nodes
        inputs.treefmt-nix.flakeModule
      ];
      perSystem =
        {
          config,
          self',
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            allowUnfree = true;
            overlays = [
              (final: prev: { graalvmPackages = final.callPackage import ./src/pkgs/graalvm; })
            ];
          };
          packages.customCaddyBuiltWithFuckingGatewayAndShit =
            pkgs.callPackage ./src/pkgs/fucking-caddy.nix
              { };
          packages.winbox = pkgs.callPackage ./src/pkgs/winbox.nix { };
          packages.wings = pkgs.callPackage ./src/pkgs/wings.nix { };
          packages.redot = pkgs.callPackage ./src/pkgs/redot.nix { };
          packages.bxt-launcher = pkgs.callPackage ./src/pkgs/bxt-launcher.nix { };
          packages.kotlin-language-server = pkgs.callPackage ./src/pkgs/kotlin-language-server.nix { };
          formatter = pkgs.nixfmt;
          apps.wings = {
            type = "app";
            program = "${self'.packages.wings}/bin/wings";
          };
          treefmt.projectRootFile = "flake.nix";
          treefmt.programs = {
            nixfmt.enable = true;
            stylua.enable = true;
          };
          apps.my-treefmt = {
            type = "app";
            program = "${config.treefmt.build.wrapper}/bin/treefmt";
          };
        };
    };
}
