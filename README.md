# nix-dotfiles

Over-engineered [Nix](https://nixos.org)-powered system configuration and dotfiles for Darwin using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Usage

1. Install Nix
    ```bash
    sh <(curl -L https://nixos.org/nix/install) --daemon
    ```
2. Launch `nix-shell` with nixUnstable
    ```bash
    nix-shell -p nixUnstable
    ```
3. Build and switch
    ```zsh
    nix build --extra-experimental-features nix-command --extra-experimental-features flakes .#darwinConfigurations.jabuk.system 
    ./result/sw/bin/darwin-rebuild switch --flake .#jabuk

## Credits

Configurations and general structure were heavily inspired by:
- [shaunsingh/nix-darwin-dotfiles](https://github.com/shaunsingh/nix-darwin-dotfiles)
- [yurrriq/dotfiles](https://github.com/yurrriq/dotfiles)
- [lucperkins/nix-home-config](https://github.com/lucperkins/nix-home-config)
