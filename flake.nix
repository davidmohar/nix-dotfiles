{
  description = "Nix-powered system configuration & dotfiles";

  inputs = {
    # Follow the latest nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      mkDarwin = hostname: darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin.nix
          ./modules/pam.nix
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          ./modules/common.nix
          ./modules/nix.nix
          ./modules/homebrew.nix
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
