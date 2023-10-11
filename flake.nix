{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  inputs.nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zig.url = "github:mitchellh/zig-overlay";
  inputs.zig.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zls.url = "github:zigtools/zls";
  inputs.zls.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zls.inputs.zig-overlay.follows = "zig";
  inputs.hyprportalpkgs.url = "github:NixOS/nixpkgs?rev=976fa3369d722e76f37c77493d99829540d43845";
  inputs.nixwaypkgs.url = "github:nix-community/nixpkgs-wayland";
  inputs.nixwaypkgs.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, home-manager, nixwaypkgs, ... }@attrs:
    let
      mkSystem = name: nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = attrs // { waypkgs = nixwaypkgs.packages.${system}; };
        modules = [
          ./src/systems/${name}
          ./src/modules/upgrade-diff.nix
          ./src/common/base69

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.ilya = import ./src/home;
          }

          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ (thewhat: super: import ./src/pkgs { pkgs = super; }) ];
          })
        ];
      }; in
    {
      packages.x86_64-linux = import ./src/pkgs {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      };
      nixosConfigurations.ilynix = mkSystem "iy";
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
