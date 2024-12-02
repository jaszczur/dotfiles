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
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    alejandra # formatter for nixfiles
    clojure
    direnv
    emacs
    fd
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
    ".config/nushell/scripts".source = ../nushell/scripts;
    ".config/nvim".source = ../nvim;
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
