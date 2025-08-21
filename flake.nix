# References:
# 1. https://github.com/ryan4yin/nix-darwin-kickstarter
# 2. https://nixos-and-flakes.thiscute.world/
# 3. https://davi.sh/blog/2024/02/nix-home-manager/

# Bootstrap:
# 1. sh <(curl -L https://nixos.org/nix/install)
# 2. nix run nix-darwin/master#darwin-rebuild --extra-experimental-features 'nix-command flakes' -- switch --flake ~/dot#cya
# 3. darwin-rebuild switch --flake ~/dot#cya

# Code:
{
  description = "nix-darwin configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      home-manager,
    }:
    let
      hostname = "cya";
      username = "cya";
      darwin_configuration =
        { pkgs, config, ... }:
        {
          # users
          users.users."${username}".home = "/Users/${username}";

          # nixpkgs
          nixpkgs.config.allowUnfree = true;
          nixpkgs.hostPlatform = "aarch64-darwin";

          # environment
          environment.systemPackages = with pkgs; [ ];

          # homebrew
          homebrew.enable = true;
          homebrew.brewPrefix = "/opt/homebrew/bin";
          homebrew.global.brewfile = true;
          homebrew.global.autoUpdate = false;
          homebrew.taps = [ ];
          homebrew.brews = [ ];
          homebrew.casks = [
            "emacs"
            "font-hack-nerd-font"
            "font-jetbrains-mono-nerd-font"
            "font-victor-mono-nerd-font"
            "google-chrome"
            "hiddenbar"
            "keka"
            "microsoft-excel"
            "microsoft-powerpoint"
            "microsoft-word"
            "miniforge"
            "neohtop"
            "r"
            "rstudio"
            "stats"
            "visual-studio-code"
            "wezterm"
          ];
          homebrew.masApps = { };
          homebrew.onActivation.cleanup = "uninstall";
          homebrew.onActivation.autoUpdate = false;
          homebrew.onActivation.upgrade = false;

          # nix
          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.auto-optimise-store = false;
          nix.gc.automatic = true;
          nix.gc.options = "--delete-older-than 7d";

          # system
          system.stateVersion = 6;
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.defaults.finder.AppleShowAllFiles = true;
          system.defaults.finder.FXEnableExtensionChangeWarning = false;
          system.defaults.finder.QuitMenuItem = true;
          system.defaults.finder.ShowPathbar = true;
          system.defaults.finder.ShowStatusBar = true;
          system.defaults.finder._FXShowPosixPathInTitle = true;
          system.defaults.finder._FXSortFoldersFirst = true;
          system.defaults.menuExtraClock.Show24Hour = true;
          system.defaults.menuExtraClock.ShowAMPM = false;
          system.defaults.menuExtraClock.ShowDayOfMonth = false;
          system.defaults.menuExtraClock.ShowDayOfWeek = false;
          system.defaults.menuExtraClock.ShowDate = 1;
          system.defaults.menuExtraClock.ShowSeconds = false;
          system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
          system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
          system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
          system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
          system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
          system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
          system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
          system.defaults.dock.autohide = true;
          system.defaults.dock.show-recents = false;
          system.defaults.dock.persistent-apps = [ "/System/Applications/launchpad.app" ];
          system.defaults.dock.orientation = "right";
          system.defaults.dock.expose-animation-duration = 0.15;
          system.defaults.dock.tilesize = 16;
          system.defaults.dock.wvous-bl-corner = 1;
          system.defaults.dock.wvous-br-corner = 1;
          system.defaults.dock.wvous-tl-corner = 1;
          system.defaults.dock.wvous-tr-corner = 1;
          system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
          system.defaults.controlcenter.BatteryShowPercentage = true;
          system.defaults.screencapture.type = "png";
          system.defaults.screencapture.disable-shadow = true;
          system.activationScripts.extraActivation.text = ''
            softwareupdate --install-rosetta --agree-to-license
          '';
          system.activationScripts.applications.text =
            let
              env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
              };
            in
            pkgs.lib.mkForce ''
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
          security.pam.services.sudo_local.touchIdAuth = true;
        };
      darwin_home_manager_configuration =
        {
          pkgs,
          config,
          lib,
          ...
        }:
        {
          home.username = "${username}";
          home.homeDirectory = "/Users/${username}";
          home.stateVersion = "24.11";
          home.activation.trampolineApps =
            let
              apps = pkgs.buildEnv {
                name = "home-manager-applications";
                paths = config.home.packages;
                pathsToLink = "/Applications";
              };
            in
            lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              toDir="$HOME/Applications/Home Manager Trampolines"
              fromDir="${apps}/Applications/"
              rm -rf "$toDir"
              mkdir "$toDir"
              (
               cd "$fromDir"
               for app in *.app; do
               /usr/bin/osacompile -o "$toDir/$app" -e 'do shell script "open '$fromDir/$app'"'
               done
              )
            '';
          home.packages = with pkgs; [
            cargo
            curl
            go
            mkalias
            neovim
            nixfmt-rfc-style
            nodejs_22
            uv
            wget
          ];
          home.file.".emacs.d/init.el".source = ./home/emacs/init.el;
          home.file.".config/nvim/init.lua".source = ./home/nvim/init.lua;
          home.file.".config/wezterm/wezterm.lua".source = ./home/wezterm/wezterm.lua;
          programs.home-manager.enable = true;
          programs.bat.enable = true;
          programs.btop.enable = true;
          programs.fastfetch.enable = true;
          programs.fzf.enable = true;
          programs.fzf.enableZshIntegration = true;
          programs.git.enable = true;
          programs.lsd.enable = true;
          programs.lsd.enableAliases = true;
          programs.ripgrep.enable = true;
          programs.ripgrep-all.enable = true;
          programs.starship.enable = true;
          programs.starship.settings.add_newline = false;
          programs.starship.settings.line_break.disabled = true;
          programs.tmux.enable = true;
          programs.tmux.aggressiveResize = true;
          programs.tmux.baseIndex = 1;
          programs.tmux.disableConfirmationPrompt = true;
          programs.tmux.mouse = true;
          programs.yazi.enable = true;
          programs.yazi.enableZshIntegration = true;
          programs.zsh.enable = true;
          programs.zsh.enableCompletion = true;
          programs.zsh.shellAliases.ff = "fastfetch";
          programs.zsh.shellAliases.vim = "nvim";
          programs.zsh.shellAliases.nv = "nvim";
          programs.zsh.shellAliases.em = "emacs -nw";
        };
    in
    {
      darwinConfigurations = {
        "${hostname}" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            darwin_configuration
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew.enable = true;
              nix-homebrew.enableRosetta = true;
              nix-homebrew.user = "${username}";
              nix-homebrew.taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              nix-homebrew.mutableTaps = false;
              nix-homebrew.autoMigrate = true;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users."${username}" = darwin_home_manager_configuration;
            }
          ];
        };
      };
    };
}
