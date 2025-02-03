{pkgs, ...}:
with pkgs; [
  alejandra # formatter for nixfiles
  bat
  carapace
  clang-tools # for clang-format used by openscad-lsp
  clojure
  coursier # for Scala
  direnv
  emacs
  eza
  fd
  fzf
  gh
  gnupg
  jdk21
  # lorri
  lua-language-server
  mkalias
  nixd
  nodejs_22
  nushell
  obsidian
  ollama
  openscad-lsp
  pnpm
  pueue
  ripgrep
  starship
  tenv
  watchexec
  wezterm
  xh
  zoxide

  #rust
  bacon
  cargo-binstall
  leptosfmt
  rustup
  trunk
]
