{ ... }:
{
	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			nix_shell = {
				disabled = true;
			};
		};
	};
}
