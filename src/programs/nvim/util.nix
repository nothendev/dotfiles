{
  keymap = rec {
    c = cmd: "<cmd>${cmd}<CR>";
    l = key: "${leader}${key}";
    leader = "<leader>";
    keymap = key: action: mode: { inherit key action mode; };
    keymapa = key: action: { inherit key action; };
    keymapl = key: action: mode: {
      inherit key mode action;
      lua = true;
    };
    silent = keymap: keymap // { options.silent = true; };
    noremap = keymap: keymap // { options.noremap = true; };
  };
}
