{
  description = "Jaszczur system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nix-homebrew,
    nixpkgs,
    home-manager,
  }: let
    configuration = profile @ {system, ...}: {
      pkgs,
      config,
      ...
    }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        alacritty
        bat
        carapace
        emacs
        eza
        fzf
        gnupg
        gnused
        jdk21
        lua-language-server
        mkalias
        nodejs_22
        nushell
        obsidian
        pinentry_mac # for gnupg
        pueue
        starship
        tmux
        vim
        wezterm
        zoxide
      ];

      environment.launchAgents = {
        "pueue.plist".text = ''
          <?xml version="1.0" encoding="UTF-8"?>

          <!-- This is the plist file for the pueue daemon on macos -->
          <!-- Place pueued.plist in ~/Library/LaunchAgents -->
          <!-- To enable the daemon navigate into the directory `cd ~/Library/LaunchAgents` and type `launchctl load pueued.plist` -->
          <!-- To start the daemon type `launchctl start pueued` -->
          <!-- If you want to check that the daemon is running type `launchctl list | grep pueued` -->
          <!-- You have to change the program location, if pueue is not installed with homebrew -->

          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
          <dict>
          	<key>Label</key>
          	<string>pueued</string>
          	<key>ProgramArguments</key>
          	<array>
          		<string>${pkgs.pueue}/bin/pueued</string>
          		<string>-vv</string>
          	</array>
          	<key>RunAtLoad</key>
          	<true/>
          </dict>
          </plist>
        '';
      };

      fonts.packages = [
        pkgs.fira-code
        pkgs.iosevka
        pkgs.nerd-fonts.fira-code
        pkgs.nerd-fonts.iosevka
        pkgs.nerd-fonts.iosevka-term
        pkgs.overpass
      ];

      homebrew = {
        enable = true;
        taps = [
          "mongodb/brew"
          "homebrew/homebrew-services"
          # "railwaycat/emacsmacport"
          # "d12frosted/emacs-plus"
        ];
        brews = [
          # "brotli" # for mongodb
          # "emacs-plus"
          # "mas"
          {
            name = "syncthing";
            # restart_service = "changed";
          }
          # "mongodb-community@8.0"
          # "mongodb-database-tools"
        ];
        casks = [
          # "emacs-mac"
          "bambu-studio"
          "firefox"
          "freecad"
          "ghostty"
          "jetbrains-toolbox"
          "karabiner-elements"
          "mqtt-explorer"
          "mullvad-browser"
          "openscad"
          "simplex"
          "vlc"
          "wezterm"
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
      nix.settings.trusted-users = ["jaszczur"];
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
        dock.persistent-apps =
          [
            # "${pkgs.alacritty}/Applications/Alacritty.app"
            # "/Applications/Ghostty.app"
            "/Applications/WezTerm.app"
            "/Applications/Firefox.app"
          ]
          ++ profile.dock.apps;
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
      nixpkgs.hostPlatform = system;
    };
    jaszczurDarwinConfig = profile @ {system, ...}:
      nix-darwin.lib.darwinSystem {
        modules = [
          (configuration profile)
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.jaszczur = (import ./jaszczur.nix) profile;
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = system == "aarch64-darwin";
              user = "jaszczur";
              autoMigrate = true;
            };
          }
        ];
      };
      jaszczurLinuxConfig = profile @ { system, ...}: let 
        pkgs = nixpkgs.legacyPackages.${system};
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            # (import ./jaszczur-linux.nix) profile
            ./jaszczur-linux.nix
          ];
      };

  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."jaszczur-work-mac" = jaszczurDarwinConfig {
      system = "aarch64-darwin";
      git.email = "piotr.jaszczyk@fortum.com";
      git.signingKey = "FFBFEEB3DB310F61";
      dock.apps = [
        "/Applications/Slack.app"
      ];
    };
    darwinConfigurations."jaszczur-priv-mac" = jaszczurDarwinConfig {
      system = "x86_64-darwin";
      git.email = "piotr.jaszczyk@gmail.com";
      dock.apps = [
        "/Applications/Rouvy.app"
        "/Applications/rekordbox 7/rekordbox.app"
      ];
    };
    homeConfigurations."silentio" = jaszczurLinuxConfig {
      system = "x86_64-linux";
      git.email = "piotr.jaszczyk@gmail.com";
    };
  };
}
