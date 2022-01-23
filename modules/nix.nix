{ pkgs, ... }:
{
	nix = {
		package = pkgs.nixUnstable;
		extraOptions = ''
			system = aarch64-darwin
			extra-platforms = aarch64-darwin x86_64-darwin
			experimental-features = nix-command flakes
			build-users-group = nixbld
		'';

		gc = {
			automatic = true;
			options = "--delete-older-than 30d";
		};
	};
}
