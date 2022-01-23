{ ... }:
{
	homebrew = {
		brewPrefix = "/opt/homebrew/bin";
		enable = true;
		autoUpdate = true;
		cleanup = "zap";
		global = {
			brewfile = true;
			noLock = true;
		};
	};
}
