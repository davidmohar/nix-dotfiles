{ pkgs, ... }:
let
	shellAliases = {
		grep = "grep --color=auto";
		ll = "ls -l";

		# zsh reload
		szsh = "source ~/.zshrc";

		# Nix garbage collection
		garbage = "nix-collect-garbage -d";
	};
in
{
	programs.zsh = {
		inherit shellAliases;

		enable = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
		enableCompletion = true;
		
		history.extended = true;

		initExtra = ''
			export TERM="xterm-256color"
			bindkey -e
		'';
	};
}
