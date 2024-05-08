{ util }:
{
  programs.nixvim = {
    keymaps = with util.keymap; [
      (noremap (
        keymapl "[flash] Start two-char jump" "s" ''
          function()
            require"flash".jump()
          end
        '' "n"
      ))
      (keymapl "[flash] Start treesitter search" (l "/") ''
        function()
          require"flash".treesitter_search()
        end
      '' "n")
      (keymap "Go to first char" "<C-a>" "^" [
        "n"
        "i"
      ])
      (keymap "Go to line start" "<C-Tab>" "0" [
        "n"
        "i"
      ])
      (silent (noremap (keymap "Remove search hl with esc" "<Esc>" "<cmd>noh<CR>" "n")))
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
