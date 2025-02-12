{pkgs, ...}:
with pkgs; [
  alejandra # formatter for nixfiles
  bat
  bottom
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
  htop
  jdk21
  kotlin-language-server
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
  yt-dlp
  zoxide

  #rust
  bacon
  cargo-binstall
  leptosfmt
  rustup
  trunk

  #zig
  zig
  zls

  # installed for ocaml stuff
  # gmp
  # pkgconf
]
