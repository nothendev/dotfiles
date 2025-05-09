local opts = {}

opts.g = {
  mapleader = " ",
  maplocalleader = "\\",
  neovide_transparency = 0.8,
}

opts.o = {
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  guifont = "JetBrainsMono Nerd Font:h13.5",
  clipboard = "unnamedplus",
  tabstop = 2,
  expandtab = true,
}

for namespace, options in pairs(opts) do
  for key, value in pairs(options) do
    vim[namespace][key] = value
  end
end
