{ pkgs, ... }: {
	programs.tmux = {
		enable = true;
		clock24 = true;
		tmuxp.enable = true;
		
		plugins = with pkgs; [
			{
				plugin = tmuxPlugins.power-theme;
				extraConfig = "set -g @tmux_power_theme 'moon'";
			}
		];

		extraConfig = ''
			# Use vi keys
			set -gw mode-keys vi

			# Window title
			set -g set-titles on
			set -g set-titles-string '#T - #I:#W'

			# Mouse
			set -g mouse on
		'';
	};
}
