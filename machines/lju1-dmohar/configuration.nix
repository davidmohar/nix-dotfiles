{ config, lib, pkgs, ...}:
let
  username = "d.mohar";
in
{
	system.stateVersion = 4;
	networking.hostName = "LJU1-dmohar";

	services.nix-daemon.enable = true;
	security.pam.enableSudoTouchIdAuth = true;

	environment.shells = with pkgs; [ zsh ];
	environment.systemPackages = with pkgs; [
		nixfmt
	];

	homebrew = {
		taps = [
			"homebrew/core"
			"homebrew/cask"
			"homebrew/cask-versions"
		];

		casks = [
			"alacritty"
			"visual-studio-code"
			"rectangle"
		];
	};

	home-manager.users."${username}" = import ./home.nix;
	users.users."${username}" = {
		home = "/Users/${username}";
		shell = pkgs.zsh;
	};
}
