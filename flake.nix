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

  outputs = { self, nixpkgs, home-manager, ... }@attrs:
    let
      mkSystem = name: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./src/systems/${name}
          ./src/modules/upgrade-diff.nix
          ./src/common/base69

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = attrs;
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
