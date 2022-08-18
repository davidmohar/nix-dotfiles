{ ... }:
{
	programs.neovim = {
		enable = true;
		vimAlias = true;
		viAlias = true;

		coc = {
			enable = true;
		};

		extraConfig = ''
			set mouse=a
		'';
	};
}
