{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      desktopManager = {
        xterm.enable = false;
      };
      displayManager = {
        lightdm = {
          enable = true;
          background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          greeters = {
            gtk = {
              theme = {
                name = "catppuccin-macchiato-pink-compact";
                package = pkgs.catppuccin-gtk.override {
                  accents = ["pink"];
                  size = "compact";
                  variant = "macchiato";
                };
              };
            };
          };
        };
        sessionCommands = ''
          xset s off
          xset -dpms
        '';
      };
      windowManager.i3.enable = true;
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  xdg.portal.config.common.default = "gtk";
}
