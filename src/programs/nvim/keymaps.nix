{
  programs.nixvim = {
    keymaps = [
      {
        action = "^";
        key = "<C-a>";
      }
      {
        action = "0";
        key = "<C-Tab>";
        mode = "n";
      }
      {
        action = "function()vim.lsp.buf.format{async=true}end";
        lua = true;
        key = "<leader>fm";
        mode = "n";
        options.silent = true;
      }
      {
        action = "<cmd>Telescope projects<CR>";
        key = "<leader>ps";
        mode = "n";
      }
      {
        action = "<cmd>Telescope fd<CR>";
        key = "<leader>ff";
        mode = "n";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fw";
        mode = "n";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        mode = "n";
      }
      {
        action = "<cmd>Telescope git_status<CR>";
        key = "<leader>g";
        mode = "n";
      }
      #{
      #  action = "<cmd>Telescope harpoon marks<CR>";
      #  key = "<leader><leader>";
      #  mode = "n";
      #}
      {
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        key = "gs";
        mode = "n";
      }
      {
        action = "<cmd>BufferLineCycleNext<CR>";
        key = "<Tab>";
        mode = "n";
        options.silent = true;
      }
      {
        action = "<cmd>BufferLineCyclePrev<CR>";
        key = "<S-Tab>";
        mode = "n";
        options.silent = true;
      }
      {
        action = "<cmd>bdelete<CR>";
        key = "<leader>x";
        mode = "n";
      }
      {
        action = "<cmd>noh<CR>";
        key = "<Esc>";
        mode = "n";
        options.silent = true;
        options.noremap = false;
      }
      {
        action = "<Esc>";
        key = "<C-c>";
        options.silent = true;
      }
      {
        action = "function()vim.diagnostic.open_float{border='rounded'}end";
        key = "<leader>f";
        mode = "n";
        lua = true;
      }
    ];
  };
}
