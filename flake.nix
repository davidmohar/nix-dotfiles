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
          ./modules/pam.nix
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          (./machines + "/${hostname}/configuration.nix")
          ({ config, pkgs, lib, ... }: {
            nixpkgs = {
              overlays = with inputs; [
                (final: prev: {
                  yabai =
                    let
                      version = "4.0.0-master";
                      buildSymlinks = prev.runCommand "build-symlinks" { } ''
                        mkdir -p $out/bin
                        ln -s /usr/bin/xcrun /usr/bin/xcodebuild /usr/bin/tiffutil /usr/bin/qlmanage $out/bin
                      '';
                    in
                      prev.yabai.overrideAttrs (old: {
                        inherit version;
                        src = inputs.yabai-src;

                        buildInputs = with prev.darwin.apple_sdk.frameworks; [
                          Carbon
                          Cocoa
                          ScriptingBridge
                          prev.xxd
                          SkyLight
                        ];

                        nativeBuildInputs = [ buildSymlinks ];
                      });
                })
              ];
            };
          })
        ];
      };
    in
    {
      darwinConfigurations = {
        "jabuk" = mkDarwin "jabuk";
      };
    };
}
