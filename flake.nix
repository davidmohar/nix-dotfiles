{
  description = "Nix-powered system configuration & dotfiles";

  inputs = {
    # Follow the latest nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yabai-src = {
      url = "github:koekeishiya/yabai";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      mkDarwin = hostname: darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          (./machines + "/${hostname}/configuration.nix")
        ];
      };
    in
    {
      darwinConfigurations = {
        "jabuk" = mkDarwin "jabuk";
      };
    };
}
