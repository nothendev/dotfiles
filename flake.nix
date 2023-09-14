{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zig.url = "github:mitchellh/zig-overlay";
  inputs.zig.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zls.url = "github:zigtools/zls";
  inputs.zls.inputs.nixpkgs.follows = "nixpkgs";
  inputs.zls.inputs.zig-overlay.follows = "zig";

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    packages.x86_64-linux = import ./pkgs { pkgs = nixpkgs.legacyPackages."x86_64-linux"; };
    nixosConfigurations.ilynix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./hardware-configuration.nix
        ./modules
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ilya = import ./home;
        }

        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [ (sf: super: import ./pkgs { pkgs = super; }) ];
        })
      ];
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
  };
}
