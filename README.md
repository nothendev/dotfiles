# The nothfiles

![my rice i guess](./rice.png)

My dotfiles.

## Stuff used

- Window manager: hyprland (catppuccin custom theme and no rounding)
- Terminal: alacritty (catppuccin theme), fish (catppuccin theme), starship (catppuccin theme)
- Editor: neovim (no nixvim anymore, plain lua is better) and sometimes when i feel like it i use neovide
- Browser: librewolf (catppuccin sapphire with ublockorigin with almost all filters on)
- Launcher: rofi with wayland patches

### Fonts

Monocraft Nerd Font

## PC specs

- CPU: amd ryzen 7 2700
- GPU: nvidia geforce gtx 1650
- RAM: 1x8GB + 1x16GB random Kingstons
- Motherboard: MSI B450M-A PRO MAX (MS-7C52)

## Maintaining

Format (treefmt configured through [flake.nix](./flake.nix)):

```sh
nix run .#my-treefmt
```
