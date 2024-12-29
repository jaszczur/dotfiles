{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jaszczur";
  home.homeDirectory = "/home/jaszczur";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs;
    [
      # bambu-studio
      # freecad
    ]
    ++ (import ./modules/packages.nix) pkgs;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = (import ./modules/files.nix) {};

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jaszczur/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat = import ./modules/bat.nix {inherit pkgs;};

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
