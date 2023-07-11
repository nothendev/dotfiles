{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
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
      ];
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
  };
}
