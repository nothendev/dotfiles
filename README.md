# The nothfiles

As you may have already guessed, this is a dotfiles repository for my [PC's](./src/systems) and homeserver setup's configuration,
specifically a NixOS setup and [colmena] [hive](./src/nodes) for my homeserver.

## Setup

Clone the repo, then decide what you want to deploy.

### Main PC setup

First, install NixOS (if you aren't running it already), then switch to this config with:

```bash
# first rebuild
sudo nixos-rebuild switch --flake .#meh
# later rebuilds (when already booted/switched into the config)
nh os switch
```

### Homeserver setup

Change values in `src/nodes/minky.nix` or any other node to fit your setup (specifically, deployment hostnames or IPs),
then run:

```bash
colmena apply --on @home
```

This will build the nodes' NixOSes and deploy them accordingly.

## Structure - `./src`

- `./src/assets` - my wallpapers and other small-enough-to-fit-in-a-public-git-repo assets
- `./src/common` - modules that don't fit in neither `./src/os` or `./src/home`, currently my `base69` system-wide theming layer (set to Catppucccin Mocha) and a Nix DSL for configuring Hyprland
- `./src/configs` - my non-Nix config files (either for things that can't be configured via Nix or things that I'm too lazy to configure with Nix i.e. shamelessly-stolen-from-the-internet-because-why-not configs), which I link in with Home Manager in `./src/home/configs.nix`
- `./src/desktop` - my desktop environment configurations. The naming convention is `${name}.home.nix` if it is for configuring it (Home Manager) or `${name}.os.nix` for system-wide setup. Also, if there is a `./src/home/${name}.nix`, that means it is the Home Manager module for it (either a copy of the one provided by Home Manager itself with my own modifications [example: `hyprland.nix`], or one I made myself [example: `river.nix`]).
- `./src/home` - my Home Manager modules
- `./src/nodes` - my [colmena] hive, currently only my homeserver setup.
- `./src/os` - my NixOS modules
  - `./src/os/services` - my services' configurations, currently Mattermost, AdGuard Home (pihole but with NixOS support) and Forgejo
- `./src/overlays` - some of my (unused) overlays
- `./src/pkgs` - my (unused) self-made Nix packages
- `./src/systems` - my NixOS systems, currently only my main PC

[colmena]: https://github.com/zhaofengli/colmena
