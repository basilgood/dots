{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    SSH_ASKPASS_REQUIRE = "prefer";
    XCURSOR_THEME = "DMZ-White";
  };

  environment.systemPackages = [
    pkgs.vanilla-dmz
    pkgs.kdePackages.ksshaskpass
    pkgs.wl-clipboard-rs
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [];

  users.users.vasy.packages = with pkgs; [
    qimgv
    # libsForQt5.ark
    libsForQt5.plasma-applet-caffeine-plus
    # libsForQt5.kwin-tiling
    libsForQt5.kcalc
    libsForQt5.kmahjongg
    polonium
  ];

  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
}
