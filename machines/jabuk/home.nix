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
		../../configs/tmux.nix
	];

	home.packages = with pkgs; [
		kubectl
		# Rust
		rustc
		cargo
		rustfmt
		# nvim coc
		nodejs
	];

	accounts.email.accounts.primary = {
		address = "david.mohar@shekaj.si";
		realName = "David Mohar";

		primary = true;
	};

	programs.ssh.enable = true;
}
