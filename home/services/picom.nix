{ pkgs, config, ... }:
{
  services.picom = {
    enable = true;
    package = pkgs.picom-next;
    backend = "glx";
    vSync = true;
    fade = true;
    fadeDelta = 5;
    fadeSteps = [
      0.04
      0.04
    ];
    fadeExclude = [
      "window_type *= 'menu'"
      "name ~= 'Firefox$'"
      "focused = 1"
    ];
    wintypes = {
      popup_menu = {
        opacity = config.services.picom.menuOpacity;
      };
      dropdown_menu = {
        opacity = config.services.picom.menuOpacity;
      };
    };
  };
}
