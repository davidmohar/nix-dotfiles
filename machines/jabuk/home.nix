{ pkgs, ... }:
{
	home.stateVersion = "21.11";

	imports = [
		../../configs/alacritty.nix
		../../configs/direnv.nix
		../../configs/fzf.nix
		../../configs/git.nix
		../../configs/neovim.nix
		../../configs/starship.nix
		../../configs/zsh.nix
	];

	home.packages = with pkgs; [

	];

	accounts.email.accounts.primary = {
		address = "david.mohar@shekaj.si";
		primary = true;
		realName = "David Mohar";
	};

	programs.ssh.enable = true;
}
