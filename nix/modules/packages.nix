{pkgs, ...}:
with pkgs; [
  alejandra # formatter for nixfiles
  clojure
  clang-tools # for clang-format used by openscad-lsp
  coursier # for Scala
  direnv
  # emacs
  fd
  gh
  # lorri
  nixd
  nushell
  ollama
  openscad-lsp
  tenv
  ripgrep
  xh

  #rust
  bacon
  cargo-binstall
  leptosfmt
  rustup
  trunk
]
