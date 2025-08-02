{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
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
            theme = {
              name = "Nordic";
              package = pkgs.nordic;
            };
          };
        };
        sessionCommands = ''
          xset s off # disable screen saver
          xset -dpms # disable screen blanking
        '';
      };
      windowManager.i3.enable = true;
    };
    displayManager.defaultSession = "none+i3";
    upower.enable = true;
    gvfs.enable = true; # thunar mount, trash, and other functionalities
    tumbler.enable = true; # thunar thumbnail support for images
  };

  programs = {
    dconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
