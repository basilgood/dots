{pkgs, ...}: {
  services.xserver.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver = {
    videoDrivers = ["amdgpu"];
    displayManager = {
      lightdm = {
        enable = true;
        background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
        greeters = {
          gtk = {
            theme = {
              name = "Nordic";
              package = pkgs.nordic;
            };
            cursorTheme = {
              name = "Nordzy-white-cursors";
              package = pkgs.nordzy-cursor-theme;
            };
          };
        };
      };
      sessionCommands = ''
        xset s off
        xset -dpms
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
      '';
    };
    windowManager.i3.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  xdg.portal.config.common.default = "gtk";
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [pkgs.xdg-desktop-portal-gtk];
  # };
}
