{
  description = "Jaszczur nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, nixpkgs, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        alacritty
        bat
        carapace
        eza
        fzf
        gnupg
        gnused
        mkalias
        nodejs_22
        nushell
        obsidian
        pinentry_mac # for gnupg
        starship
        tmux
        vim
        zoxide
      ];

      fonts.packages = [
        pkgs.fira-code
        pkgs.iosevka
        (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "IosevkaTerm" ]; })
        pkgs.overpass
      ];

      homebrew = {
        enable = true;
        taps = [
            "mongodb/brew"
            "homebrew/homebrew-services"
        ];
        brews = [
            # "brotli" # for mongodb
            # "emacs-mac"
            # "mas"
            {
              name = "syncthing";
              # restart_service = "changed";
            }
            "mongodb-community@8.0"
            # "mongodb-database-tools"
          ];
        casks = [
          "firefox"
          "jetbrains-toolbox"
          "karabiner-elements"
          "mullvad-browser"
          "simplex"
        ];
        masApps = {
          "Bitwarden" = 1352778147;
          "Slack" = 803453959;
          "Telegram" = 747648890;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };
      

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      # nix.settings.trusted-substituters = [
      #     "https://devenv.cachix.org"
      # ];
      # nix.settings.trusted-public-keys = [ 
      #   "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      # ];


      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      security.pam.enableSudoTouchIdAuth = true;

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
          '';

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;


      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
            "${pkgs.alacritty}/Applications/Alacritty.app"
            "/Applications/Firefox.app"
            "/Applications/Slack.app"
          ];
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.KeyRepeat = 1;
        NSGlobalDomain.InitialKeyRepeat = 10;
        NSGlobalDomain.ApplePressAndHoldEnabled = false;
      };

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      users.users.jaszczur = {
        name = "jaszczur";
        home = "/Users/jaszczur";
      };

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };

  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."jaszczur-work-mac" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.jaszczur = import ./jaszczur.nix;
          };
        }
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "jaszczur";
              autoMigrate = true;
          };
        }
      ];
    };
  };
}
