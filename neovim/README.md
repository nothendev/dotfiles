# The Wanderer-forsaken neovim setup

And now, I shall explain this cursed setup.

[`init.lua`](./init.lua):
- applies [`ultravim/opts.lua`](./lua/ultravim/opts.lua), which sets a few `vim.g`s and `vim.o`s here and there
- applies [`ultravim/map.lua`](./lua/ultravim/map.lua) which (right now) only sets `<C-c>` to `<Esc>` because yes
- and finally, jumpstarts [lazy.nvim](https://github.com/folke/lazy.nvim),\
which loads the [catppuccin](https://github.com/catppuccin/nvim) colorscheme,\
and then goes through the [`ultravim/plugins`] folder.

In the [`ultravim/plugins`] folder are:
- [`cmp.lua`](./lua/ultravim/plugins/cmp.lua) which sets up [`blink.cmp`](https://github.com/saghen/blink.cmp), and coincidentally, [`lazydev.nvim`](https://github.com/folke/lazydev.nvim)
- [`ui.lua`](./lua/ultravim/plugins/ui.lua), which is responsible for most of the prettiness of said setup, loads:
  - [`noice.nvim`](https://github.com/folke/noice.nvim)
  - [`dressing.nvim`](https://github.com/stevearc/dressing.nvim)
  - [`snacks.nvim`](https://github.com/folke/snacks.nvim)
  - [`which-key.nvim`](https://github.com/folke/which-key.nvim)
  - [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim)
  - [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
- [`flash.lua`](./lua/ultravim/plugins/flash.lua) sets up [`flash.nvim`](https://github.com/folke/flash.nvim)
- [`motion.lua`](./lua/ultravim/plugins/motion.lua) sets up [`nvim-surround`](https://github.com/kylechui/nvim-surround), [`ts-comments.nvim`](https://github.com/folke/ts-comments.nvim) and [`harpoon`](https://github.com/theprimeagen/harpoon)

(others are to be described later)

[`ultravim/plugins`]: ./lua/ultravim/plugins
