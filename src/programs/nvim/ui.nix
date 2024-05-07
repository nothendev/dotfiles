# nothvim UI
{ util }:
{
  programs.nixvim = {
    keymaps = with util.keymap; [
      (keymapl "<leader>f" ''
        function ()
          vim.diagnostic.open_float{
            border = 'rounded'
          }
        end
      '' "n")
              (keymap (l"ps")        (c"Telescope projects")              "n")
              (keymap (l"ff")        (c"Telescope fd")                    "n")
              (keymap (l"fw")        (c"Telescope live_grep")             "n")
              (keymap (l"fb")        (c"Telescope buffers")               "n")
              (keymap (l"g")         (c"Telescope git_status")            "n")
              (keymap (Cl"")         (c"Telescope harpoon marks")         "n")
              (keymap "gs"           (c"Telescope lsp_document_symbols")  "n")
              (keymap "gS"           (c"Telescope lsp_workspace_symbols") "n")
      (silent (keymap "<Tab>"        (c"BufferLineCycleNext")             "n"))
      (silent (keymap "<S-Tab>"      (c"BufferLineCyclePrev")             "n"))
              (keymap (l"x")         (c"bdelete")                         "n")
              (keymap (l"X")         (c"bdelete!")                        "n")
    ];
    plugins = {
      dressing.enable = true;
      bufferline.enable = true;
      telescope.enable = true;
      telescope.extensions.project-nvim.enable = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      twilight.enable = true;
      trouble.enable = true;
      trouble.mode = "document_diagnostics";
      gitgutter.enable = true;
      which-key.enable = true;
    };
  };
}
