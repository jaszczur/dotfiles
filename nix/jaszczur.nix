profile: {
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: {
  home = {
    # username = "jaszczur";
    # homeDirectory = profile.homeDirectory;
    sessionPath = ["$HOME/.local/bin" "$HOME/.deno/bin/" "/opt/homebrew/bin"];
    language = {
      base = "en_US.UTF-8";
    };
    stateVersion = "24.11";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SDKROOT = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk";
      CC = "clang";
      XDG_CONFIG_HOME = "/Users/jaszczur/.config";
      AWS_REGION = "eu-west-1";
    };
    shellAliases = {
      ll = "eza -l";
      la = "eza -a";
      l = "eza";
      ngit = "nvim -c \":lua require('neogit').open()\"";
    };
  };

  home.packages = (import ./modules/packages.nix) pkgs;
  # ++ (builtins.attrValues darwin.apple_sdk.frameworks);

  home.file = (import ./modules/files.nix) {};

  launchd.agents = {
    # "lorri" = {
    #   enable = true;
    #   config = {
    #     Label = "com.github.target.lorri";
    #     WorkingDirectory = "/Users/jaszczur";
    #     EnvironmentVariables = {"TMPDIR" = "/private/tmp";};
    #     KeepAlive = true;
    #     RunAtLoad = true;
    #     StandardOutPath = "/private/tmp/lorri.log";
    #     StandardErrorPath = "/private/tmp/lorri.log";
    #     ProgramArguments = ["${pkgs.lorri}/bin/lorri" "daemon"];
    #   };
    # };
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

  programs.bat = import ./modules/bat.nix {inherit pkgs;};

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.starship = {
    enable = true;
    # enableNushellIntegration = true; # I'll do it myself
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      aws.disabled = true;
      # time.disabled = true;
    };
  };

  programs.zsh = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      toggle-theme = ''
        set current_theme $THEME
        if test "$current_theme" = "dark"
            set new_theme "light"
            set theme_variant "Catppuccin Latte"
        else
            set new_theme "dark"
            set theme_variant "Catppuccin Mocha"
        end
        fish_config theme choose "$theme_variant"
        set -gx THEME $new_theme
        echo "Theme switched to $new_theme ($theme_variant)"
      '';
    };
  };

  programs.git = let
    hasSigningKey = profile.git ? signingKey;
  in {
    enable = true;
    userName = "Piotr Jaszczyk";
    userEmail = profile.git.email;
    signing.signByDefault = hasSigningKey;
    signing.key =
      if hasSigningKey
      then profile.git.signingKey
      else null;
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

  programs.opam = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
