{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:nothendev/doomer";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";
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
    codeium-nvim.url = "github:Exafunction/codeium.nvim";
    codeium-nvim.inputs.nixpkgs.follows = "nixpkgs";
    nvim.url = "github:neovim/neovim?dir=contrib";
    nvim.inputs.nixpkgs.follows = "nixpkgs";
    fomt.url = "git+https://codeberg.org/noth/forgmartelo?ref=feat/repo_new";
    fomt.inputs.nixpkgs.follows = "nixpkgs";
  };

  # nixConfig = {
  #   substituters = [ "https://hyprland.cachix.org" ];
  #   trusted-public-keys =
  #     [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  # };

  outputs =
    { self, nixpkgs, home-manager, nixwaypkgs, codeium-nvim, ... }@attrs:
    let
      mkSystem = name:
        nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = attrs // { waypkgs = nixwaypkgs.packages.${system}; inherit system; };
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
              nixpkgs.overlays = [
                (thewhat: super: import ./src/pkgs { pkgs = super; })
                codeium-nvim.overlays.${system}.default
              ];
            })
          ];
        };
    in
    {
      packages.x86_64-linux =
        import ./src/pkgs { pkgs = nixpkgs.legacyPackages."x86_64-linux"; };
      nixosConfigurations.ilynix = mkSystem "iy";
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}
