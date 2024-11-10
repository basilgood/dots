{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      desktopManager = {
        xterm.enable = false;
      };
      # dpi = 110;
      # upscaleDefaultCursor = true;
      displayManager = {
        lightdm = {
          enable = true;
          background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          greeters.gtk = {
            enable = true;
            theme.name = "Adwaita-dark";
            iconTheme.name = "Adwaita-dark";
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
}
