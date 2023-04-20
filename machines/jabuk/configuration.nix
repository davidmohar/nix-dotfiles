{ pkgs, home-manager, ... }:
let
  username = "davidm";
in
{
	networking.hostName = "jabuk";

	services.nix-daemon.enable = true;
	security.pam.enableSudoTouchIdAuth = true;

	programs.zsh.enable = true;
	environment.shells = with pkgs; [ zsh ];
	environment.systemPackages = with pkgs; [
		nixfmt
		direnv
	];

	homebrew = {
		brews = [
			"pam-reattach"
			"ext4fuse"
		];

		taps = [
			"homebrew/core"
			"homebrew/cask"
			"homebrew/cask-versions"
		];

		casks = [
			"alacritty"
			"visual-studio-code"
			"rectangle"
			"firefox"
			"steam"
			"bitwarden"
			"discord"
			"wireshark"
			"macfuse"
			"raspberry-pi-imager"
			"adobe-acrobat-reader"
			"foxitreader"
		];
	};
	home-manager.users."${username}" = import ./home.nix;
	users.users."${username}" = {
		#home = "/Users/${username}";
		shell = pkgs.zsh;
	};

	nixpkgs.config.allowBroken = true;

	services.yabai = {
		enable = false;
		enableScriptingAddition = false;
		package = pkgs.yabai;
		
		config = {
			layout = "bsp";
			auto_balance = "on";
			split_ratio = "0.5";
			window_placement = "second_child";

			window_gap = 5;
			top_padding = 5;
			bottom_padding = 5;
			left_padding = 5;
			right_padding = 5;

			window_shadow = "on";
			window_border = "off";
			window_border_width = 2;
			window_opacity = "on";
			window_opacity_duration = "0.1";
			active_window_opacity = "1.0";
			normal_window_opacity = "0.9";

			mouse_modifier = "cmd";
			mouse_action1 = "move";
			mouse_action2 = "resize";
			mouse_drop_action = "swap";
		};

		extraConfig = ''
			yabai -m rule --add app='System Preferences' manage=off
			yabai -m rule --add app='Finder' manage=off
			yabai -m rule --add app='Activity Monitor' manage=off
			yabai -m rule --add app='Bitwarden' manage=off
		'';
	};

	services.skhd = {
		enable = false;
		package = pkgs.skhd;

		skhdConfig = ''
			cmd - return : alacritty

			# focus
			lalt - h : yabai -m window --focus west
			lalt - j : yabai -m window --focus south
			lalt - k : yabai -m window --focus northz
			lalt - l : yabai -m window --focus east

			# swap
			shift + lalt - h : yabai -m window --swap west
			shift + lalt - j : yabai -m window --swap south
			shift + lalt - k : yabai -m window --swap north
			shift + lalt - l : yabai -m window --swap east

			# spaces
			alt + ctrl - q : yabai -m space --focus prev
			alt + ctrl - e : yabai -m space --focus next

			ralt - x : yabai -m space --focus recent
			ralt - 1 : yabai -m space --focus 1
			ralt - 2 : yabai -m space --focus 2
			ralt - 3 : yabai -m space --focus 3
			ralt - 4 : yabai -m space --focus 4
			ralt - 5 : yabai -m space --focus 5
			ralt - 6 : yabai -m space --focus 6
			ralt - 7 : yabai -m space --focus 7
			ralt - 8 : yabai -m space --focus 8

			# float / unfloat window
			ralt - t : yabai -m window --toggle float;\
			           yabai -m window --grid 4:4:1:1:2:2
			
			ralt - d : yabai -m window --toggle zoom-parent
		'';
	};
}
