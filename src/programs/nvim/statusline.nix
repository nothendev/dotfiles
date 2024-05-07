{
  programs.nixvim = {
    extraConfigVim = ''
      function StatuslineMode()
        let m = mode(1)
        if m[0] ==# "i"
          let mode = 'insert'  " Insert modes + submodes (i, ic, ix)
        elseif m[0] == "R"
          let mode = 'replace'  " Replace modes + submodes (R, Rc, Rv, Rx) (NB: case sensitive as 'r' is a mode)
        elseif m[0] =~ '\v(v|V||s|S|)'
          let mode = 'visual'  " Visual and Select modes (v, V, ^V, s, S, ^S))
        elseif m ==# "t"
          let mode = 'terminal'  " Terminal mode (only has one mode (t))
        elseif m[0] =~ '\v(c|r|!)'
          let mode = 'commandline'  " c, cv, ce, r, rm, r? (NB: cv and ce stay showing as mode entered from)
        else
          return ""  " Normal mode + submodes (n, niI, niR, niV; plus operator pendings no, nov, noV, no^V)
        endif

        return toupper(mode).' '
      endfunction
    '';

    options = {
      showmode = false;
      ruler = false;
      statusline = "%<%{StatuslineMode()}%f %h%m%r%=%-14.(%l,%c%V%) %P";
    };
  };
}
