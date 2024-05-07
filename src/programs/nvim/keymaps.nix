{ util }:
{
  programs.nixvim = {
    keymaps = with util.keymap; [
      (keymapl "<S-Space>" ''
        function()
          require"flash".jump()
        end
      '' "n")
      (keymapl (l"/") ''
        function()
          require"flash".treesitter_search()
        end
      '' "n")
      (keymap "<C-a>" "^" ["n" "i"])
      (keymap "<C-Tab>" "0" ["n" "i"])
      (silent (noremap (keymap "<Esc>" "<cmd>noh<CR>" "n")))
      (keymapa "<C-c>" "<Esc>")
    ];
  };
}
