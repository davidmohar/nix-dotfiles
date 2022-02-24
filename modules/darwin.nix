{ pkgs, nix-darwin, ... }: 
{
	nix = {
		package = pkgs.nixUnstable;
		extraOptions = ''
			system = aarch64-darwin
			extra-platforms = aarch64-darwin x86_64-darwin
			experimental-features = nix-command flakes
			build-users-group = nixbld
		'';

		gc = {
			automatic = true;
			options = "--delete-older-than 30d";
		};
	};

	homebrew = {
		brewPrefix = "/opt/homebrew/bin";
		enable = true;
		autoUpdate = true;
		cleanup = "zap";
		global = {
			brewfile = true;
			noLock = true;
		};
	};

	fonts = {
		enableFontDir = true;
		fonts = with pkgs; [
			fira
			fira-code
		];
	};

  system.keyboard = {
    enableKeyMapping = true;
  };

  system.defaults = {
    dock = {
      autohide = true;
      minimize-to-application = true;
      mru-spaces = false;
      show-recents = false;
      tilesize = 32;
    };
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;    
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };
  };

  system.stateVersion = 4;
}
