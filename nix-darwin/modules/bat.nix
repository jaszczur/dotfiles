{ pkgs, ...}:
{
    enable = true;
    themes = let
      catppuccin_src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
        sha256 = "sha256-x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
      };
    in {
      catppuccin-latte = { src = catppuccin_src;
        file = "themes/Catppuccin Latte.tmTheme";
      };
      catpuccin-frappe = {
        src = catppuccin_src;
        file = "themes/Catppuccin Frappe.tmTheme";
      };
      catpuccin-macchiato = {
        src = catppuccin_src;
        file = "themes/Catppuccin Macchiato.tmTheme";
      };
      catpuccin-mocha = {
        src = catppuccin_src;
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };

    config = {
      theme = "catpuccin-macchiato";
    };
  }
