{pkgs, ...}:
with pkgs; [
  alejandra # formatter for nixfiles
  bacon
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
  openscad-lsp
  tenv
  ripgrep
  rustup
  xh
]
