{ config, pkgs, lib, home-manager, ... }:

{
  home = {
    stateVersion = "24.11";
    # homeDirectory = "/Users/jaszczur";
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

  # programs.nushell = {
  #   enable = true;
  # };

  programs.starship = {
    enable = true;
    # enableNushellIntegration = true;
    settings = {
      add_newline = true;
      # time.disabled = true;
    };
  };

}
