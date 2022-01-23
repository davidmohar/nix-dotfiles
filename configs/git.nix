{ config, ... }:
let
	aliases = {
		co = "checkout";
		cob = "checkout -b";
		cm = "commit -m";
		ca = "commit --amend";
		pr = "pull --rebase";
	};
in
{
	programs.git = {
		enable = true;
		inherit aliases;

		ignores = [
			".DS_Store" 
			".envrc"
			".vscode"            
		];
		delta = {
			enable = true;
			options = {
				line-numbers = true;
			};
		};
		extraConfig = {
			core = {
				editor = "vim";
				whitespace = "trailing-space";
			};
			init.defaultBranch = "master";
			pull.ff = "only";
		};
	} // (
		with config.accounts.email.accounts.primary; {
			userEmail = address;
			userName = realName;
		}
	);
}
