# The nothfiles

![My rice](./rice.png)

My dotfiles.

## Stuff used

- Window manager: Sway. It's just awesome.
- Terminal: Ghostty (material ocean theme, it's hella nice check it out) + Zellij + Fish
- Editor: Intellij IDEA for actual coding and nvim for configs
- Browser: Brave
- Launcher: rofi with wayland patches

## Fonts

- Code: JetBrainsMono Nerd Font
- UI: ShantellSans SemiBold

## PC specs

- CPU: AMD Ryzen 7 2700
- GPU: NVidia GeForce GTX 1650
- RAM: 1x8GB (non-functional in one slot) + 1x16GB random Kingstons
- Motherboard: MSI B450M-A PRO MAX (MS-7C52)

## Maintaining

Format (treefmt configured through [flake.nix](./flake.nix)):

```sh
nix run .#my-treefmt
```
