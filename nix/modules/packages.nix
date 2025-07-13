{pkgs, ...}:
with pkgs; [
  alejandra # formatter for nixfiles
  bat
  bottom
  carapace
  clang-tools # for clang-format used by openscad-lsp
  clojure
  coursier # for Scala
  # deno # too old version, need to use deno provided installer
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
  luarocks
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
  uv
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
  minisign
  zig
  zls

  # installed for ocaml stuff but using native package manager (homebrew for Mac)
  # gmp
  # pkgconf
]
