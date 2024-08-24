{
  self,
  inputs,
  lib,
  ...
}:
let
  systems =
    lib.genAttrs
      [
        "minky"
        "pinos"
        "dungeon"
        "omema"
      ]
      (
        name:
        inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs // {
            inherit self;
            system = "x86_64-linux";
          };
          modules = [
            ./_deployment.nix
            ./${name}.nix
          ];
        }
      );
in
{
  flake = {
    nixosConfigurations = systems;
    deploy.nodes = lib.mapAttrs (key: system: {
      sshUser = "root";
      hostname = system.config.deployment.targetHost or key;
      profiles.system = {
        user = system.config.deployment.targetUser;
        path = inputs.deploy.lib.x86_64-linux.activate.nixos system;
      };
    }) systems;

    checks = builtins.mapAttrs (_: deployLib: deployLib.deployChecks self.deploy) inputs.deploy.lib;
  };
}
