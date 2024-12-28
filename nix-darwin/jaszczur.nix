profile: {
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: {
  home = {
    # username = "jaszczur";
    # homeDirectory = /Users/jaszczur;
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
    };
  };

  home.packages = with pkgs;
    [
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
      openscad-lsp
      tenv
      ripgrep
      rustup
      xh
    ]
    ++ (builtins.attrValues darwin.apple_sdk.frameworks);

  home.file = {
    ".config/nushell/env.nu".source = ../nushell/env.nu;
    ".config/nushell/config.nu".source = ../nushell/config.nu;
    ".config/nushell/scripts".source = ../nushell/scripts;
    ".config/ghostty/config".source = ../ghostty/config;
    ".config/wezterm".source = ../wezterm;
    ".tmux.conf".source = ../tmux/tmux.conf;
    # ".config/nvim".source = ../nvim; # it's pain in the ass to manage it by nix
  };

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

  nixpkgs.config = {
    allowUnfree = true;
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
      # time.disabled = true;
    };
  };

  programs.zsh = {
    enable = true;
  };
}
