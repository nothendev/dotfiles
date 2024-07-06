# nothvim UI
{ util }:
{
  programs.nixvim = {
    keymaps = with util.keymap; [
      (keymapl "Open diagnostic in float" "<leader>f" ''
        function ()
          vim.diagnostic.open_float{
            border = 'rounded'
          }
        end
      '' "n")
      (keymap "[telescope] Open projects" (l "ps") (c "Telescope projects") "n")
      (keymap "[telescope] Search for files" (l "ff") (c "Telescope fd") "n")
      (keymap "[telescope] Search in files (live grep)" (l "fw") (c "Telescope live_grep") "n")
      (keymap "[telescope] List buffers" (l "fb") (c "Telescope buffers") "n")
      (keymap "[telescope] Git status" (l "g") (c "Telescope git_status") "n")
      (keymap "[telescope] Search document symbols" "gs" (c "Telescope lsp_document_symbols") "n")
      (keymap "[telescope] Search workspace symbols" "gS" (c "Telescope lsp_workspace_symbols") "n")
      # (silent (keymap "[bufferline] Go to next tab" "<Tab>" (c "BufferLineCycleNext") "n"))
      # (silent (keymap "[bufferline] Go to prev tab" "<S-Tab>" (c "BufferLineCyclePrev") "n"))
      # (keymap "[bufferline] Close current tab" (l "x") (c "bdelete") "n")
      # (keymap "[bufferline] Force close current tab" (l "X") (c "bdelete!") "n")
    ];
    plugins = {
      dressing.enable = true;
      bufferline.enable = false;
      telescope.enable = true;
      project-nvim.enableTelescope = true;
      todo-comments.enable = true;
      rainbow-delimiters.enable = true;
      twilight.enable = true;
      trouble.enable = true;
      trouble.settings.mode = "document_diagnostics";
      gitgutter.enable = true;
      which-key.enable = true;
    };
  };
}
