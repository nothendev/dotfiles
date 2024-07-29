local opts = {}

opts.g = {
  mapleader = " ",
  maplocalleader = "\\",
}

opts.o = {
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  guifont = "JetBrainsMono Nerd Font:h13.5",
  clipboard = "unnamedplus",
}

for namespace, options in pairs(opts) do
  for key, value in pairs(options) do
    vim[namespace][key] = value
  end
end
