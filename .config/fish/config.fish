set -U fish_greeting
starship init fish | source
starship completions fish | source
set -gx EDITOR nvim
set -gx PATH "/home/ilya/.cargo/bin" $PATH
set -gx PATH "/home/ilya/.local/share/JetBrains/Toolbox/scripts" $PATH
set -gx PATH "/home/ilya/.konan/kotlin-native-prebuilt-linux-x86_64-1.8.0" $PATH
set -gx PNPM_HOME "/home/ilya/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
set -gx PATH "/home/ilya/.local/bin" $PATH
set -gx PATH "/home/ilya/.nix-profile/bin" $PATH
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx DENO_INSTALL "/home/ilya/.deno"
set -gx PATH $DENO_INSTALL/bin $PATH
set -gx PATH "/home/ilya/.config/emacs/bin" $PATH
set -gx PATH "/home/ilya/.local/share/coursier/bin" $PATH

ls > /dev/null
