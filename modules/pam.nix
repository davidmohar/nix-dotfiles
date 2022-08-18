# https://github.com/shaunsingh/nix-darwin-dotfiles/blob/main/modules/pam.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.security.pam;
  mkSudoTouchIdAuthScript = isEnabled:
    let
      file = "/etc/pam.d/sudo";
      option = "security.pam.enableSudoTouchIdAuth";
    in ''
      ${if isEnabled then ''
        # Enable sudo Touch ID authentication, if not already enabled
        if ! grep 'pam_tid.so' ${file} > /dev/null; then
          sed -i "" '2i\
        auth       optional       /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh # nix-darwin: ${option} \
        auth       sufficient     pam_tid.so # nix-darwin: ${option}
          ' ${file}
        fi
      '' else ''
        # Disable sudo Touch ID authentication, if added by nix-darwin
        if grep '${option}' ${file} > /dev/null; then
          sed -i "" '/${option}/d' ${file}
        fi
      ''}
    '';

in {
  options = {
    security.pam.enableSudoTouchIdAuth = mkEnableOption ''
      Enable sudo authentication with Touch ID. Make sure to also install pam-reattach brew so
      that TouchID will also work inside tmux sessions.
      When enabled, this option adds the following lines to /etc/pam.d/sudo:
          auth       optional       /opt/homebrew/lib/pam/pam_reattach.so ignore_ssh
          auth       sufficient     pam_tid.so
      (Note that macOS resets this file when doing a system update. As such, sudo
      authentication with Touch ID won't work after a system update until the nix-darwin
      configuration is reapplied.)
    '';
  };

  config = {
    system.activationScripts.extraActivation.text = ''
      # PAM settings
      echo >&2 "setting up pam..."
      ${mkSudoTouchIdAuthScript cfg.enableSudoTouchIdAuth}
    '';
  };
}
