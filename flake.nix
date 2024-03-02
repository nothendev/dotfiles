{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";
    zls.url = "github:zigtools/zls";
    zls.inputs.nixpkgs.follows = "nixpkgs";
    zls.inputs.zig-overlay.follows = "zig";
    hyprland.url = "github:hyprwm/Hyprland";
    nixwaypkgs.url = "github:nix-community/nixpkgs-wayland";
    nixwaypkgs.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nvim.url = "github:neovim/neovim?dir=contrib&rev=4e59422e1d4950a3042bad41a7b81c8db4f8b648";
    nvim.inputs.nixpkgs.follows = "nixpkgs";
    fjo.url = "git+https://codeberg.org/VoiDD/fjo";
    fjo.inputs.nixpkgs.follows = "nixpkgs";
    nh.url = "github:viperML/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";
    mattermost-plugin-focalboard.url = "file+https://github.com/mattermost/focalboard/releases/download/v7.10.6/mattermost-plugin-focalboard.tar.gz";
    mattermost-plugin-focalboard.flake = false;
    mattermost-plugin-jitsi.url = "file+https://github.com/mattermost/mattermost-plugin-jitsi/releases/download/v2.0.1/jitsi-2.0.1.tar.gz";
    mattermost-plugin-jitsi.flake = false;
  };

  # nixConfig = {
  #   substituters = [ "https://hyprland.cachix.org" ];
  #   trusted-public-keys =
  #     [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  # };

  outputs =
    { self, nixpkgs, home-manager, nixwaypkgs, nh, ... }@inputs:
    let
      mkSystem = name:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = inputs // { waypkgs = nixwaypkgs.packages.${system}; inherit system; };
          modules = [
            ./src/systems/${name}.nix
            ./src/systems/${name}.hardware.nix
            ./src/os/upgrade-diff.nix
            ./src/common/base69

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.ilya = import ./src/home;
            }

            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [
                (_: super: import ./src/pkgs { pkgs = super; })
              ];

              environment.systemPackages = [ nh.packages.${system}.default ];

              environment.variables.FLAKE = "/home/ilya/dotfiles";
            })
          ];
        };
    in
    {
      nixosConfigurations.meh = mkSystem "meh";
      colmena = import ./src/nodes { inherit nixpkgs inputs; };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      packages.x86_64-linux.wings = nixpkgs.legacyPackages.x86_64-linux.callPackage ./src/pkgs/wings.nix { };
      apps.x86_64-linux.wings = {
        type = "app";
        program = "${self.packages.x86_64-linux.wings}/bin/wings";
      };
    };
}
