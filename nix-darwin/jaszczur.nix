{ config, pkgs, lib, home-manager, ... }:

{
  home = {
    # username = "jaszczur";
    # homeDirectory = /Users/jaszczur;
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    clojure
    gh
    nixd
    tenv
    ripgrep
    rustup
    xh
  ];

  home.file = {
    ".config/nushell/env.nu".source = ../nushell/env.nu;
    ".config/nushell/config.nu".source = ../nushell/config.nu;
  };

  programs.awscli = {
    enable = true;
    settings = {
      "default" = {
        defaultRegion = "eu-west-1";
        output = "json";
      };
    };
  };

  programs.bat = {
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
  };

  programs.git = {
    enable = true;
    userName = "Piotr Jaszczyk";
    userEmail = "piotr.jaszczyk@fortum.com";
    signing.key = "FFBFEEB3DB310F61";
    signing.signByDefault = true;
    aliases = {
      br = "branch";
      co = "checkout";
      ci = "commit";
      st = "status";
    };
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.nushell = {
    enable = true;
    environmentVariables = {
    };
  };

  programs.starship = {
    enable = true;
    # enableNushellIntegration = true;
    settings = {
      add_newline = true;
      # time.disabled = true;
    };
  };

}
