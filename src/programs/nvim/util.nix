{
  keymap = rec {
    c = cmd: "<cmd>${cmd}<CR>";
    l = key: "${leader}${key}";
    Cl = key: "<C-Space>${key}";
    leader = "<leader>";
    keymap = desc: key: action: mode: {
      inherit key action mode;
      options.desc = desc;
    };
    keymapa = desc: key: action: {
      inherit key action;
      options.desc = desc;
    };
    keymapl = desc: key: action: mode: {
      inherit key mode action;
      options.desc = desc;
      lua = true;
    };
    silent = keymap: keymap // { options.silent = true; };
    noremap = keymap: keymap // { options.noremap = true; };
  };
}
