{ util }:
{
  programs.nixvim = {
    keymaps = with util.keymap; [
      (noremap (keymapl "s" ''
        function()
          require"flash".jump()
        end
      '' "n"))
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

    plugins = {
      flash.enable = true;
      surround.enable = true;
      comment-nvim.enable = true;
      comment-nvim.toggler = {
        line = "<leader>c";
        block = "<leader>C";
      };
      nvim-autopairs.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymaps = with util.keymap; {
          addFile = Cl "a";
          navNext = Cl "j";
          navPrev = Cl "k";
        };
      };
    };
  };
}
