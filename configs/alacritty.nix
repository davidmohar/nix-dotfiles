{ pkgs, ... }:
{
	programs.alacritty = {
		enable = true;
		package = pkgs.runCommand "alacritty-0.0.0" { } "mkdir $out";
		settings = {
			window.padding.x = 5;
			window.padding.y = 5;
			window.dynamic_title = true;
			live_config_reload = true;
			mouse.hide_when_typing = true;
			use_thin_strokes = true;
			cursor.style = "Beam";
			window.opacity = 0.9;

			font = {
				size = 10;
				normal.family = "Fira Code";
				normal.style = "Light";
				bold.family = "Fira Code";
				bold.style = "Bold";
				italic.family = "Fira Code";
				italic.style = "Light";
			};
		};
	};
}
