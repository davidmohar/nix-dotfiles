{ pkgs, ... }: {
	programs.zsh = {
		enable = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
		enableCompletion = true;
		
		history.extended = true;

		shellAliases = {
			grep = "grep --color=auto";
			ll = "ls -l";
			cat = "bat";

			# zsh reload
			szsh = "source ~/.zshrc";

			# Nix garbage collection
			garbage = "nix-collect-garbage -d";
		};

		initExtra = ''
			export TERM="xterm-256color"
			bindkey -e
		'';
	};

	programs.bat.enable = true;
}
