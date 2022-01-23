{ pkgs, ... }:
{
	fonts = {
		enableFontDir = true;
		fonts = with pkgs; [
			fira
			fira-code
		];
	};
}
