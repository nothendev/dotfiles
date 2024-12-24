local map = vim.keymap.set

map("i", "<C-c>", "<Esc>", { silent = true })
map("n", "<C-a>", "^", { noremap = true, silent = true })

pcall(vim.keymap.del, "n", "grn")
pcall(vim.keymap.del, { "n", "x" }, "gra")
pcall(vim.keymap.del, "n", "grr")
