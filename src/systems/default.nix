{ inputs, ... }:
let
  mkSystem =
    name:
    inputs.nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = inputs // {
        waypkgs = inputs.nixwaypkgs.packages.${system};
        inherit inputs system;
      };
      modules = [
        ./${name}.nix
        ../common/base69

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.ilya = import ../home;
        }

        {
          nix.settings.sandbox = false;
          nixpkgs.overlays = [
            (final: prev: { graalvmPackages = final.callPackage ../pkgs/graalvm { }; })
          ];

          programs.nh = {
            enable = true;
            flake = "/home/ilya/dotfiles";
          };
        }
      ];
    };
in
{
  flake.nixosConfigurations = {
    meh = mkSystem "meh";
  };
}
