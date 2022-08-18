{ config, lib, pkgs, nix-darwin, home-manager, ...}:
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
		enable = true;
		autoUpdate = true;

		brews = [
			"pam-reattach"
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
		];
	};

	home-manager.users."${username}" = import ./home.nix;
	users.users."${username}" = {
		home = "/Users/${username}";
		shell = pkgs.zsh;
	};

	nixpkgs.config.allowBroken = true;
}
