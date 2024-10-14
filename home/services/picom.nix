{pkgs, ...}: let
  my_picom = pkgs.picom.overrideAttrs (oa: {
    src = pkgs.fetchgit {
      url = "https://github.com/yshui/picom";
      rev = "6caa76a281e906784deb05038e38919e878be6e0";
      hash = "sha256-05jiIVNubAv8Dby/Tbkag6uB4U/aX58gTKI2NxbKqCU";
    };
    nativeBuildInputs =
      (oa.nativeBuildInputs or [])
      ++ [
        pkgs.pcre
      ];
  });
in {
  services.picom = {
    enable = true;
    package = my_picom;
    vSync = true;
    backend = "glx";

    settings = {
      animations = true;
      animation-window-mass = 1;
      animation-dampening = 20;
      animation-stiffness = 250;
      animation-clamping = false;
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "zoom";
      animation-for-transient-window = "slide-down";

      fade-in-step = 0.028;
      fade-out-step = 0.028;

      focus-exclude = ["class_g ?= 'rofi'" "class_g ?= 'Steam'"];
      rounded-corners-exclude = [
        "! name~=''"
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g ?= 'Dunst'"
      ];

      corner-radius = 10;
      round-borders = 0;
      round-borders-exclude = [
        "! name~=''" # Qtile == empty wm_class..
      ];

      detect-rounded-corners = true;
      detect-client-opacity = true;

      invert-color-include = [];
      glx-no-stencil = true;
      use-damage = false;
      transparent-clipping = false;
      fading = true;
    };

    wintypes = {
      dock = {animation = "slide-down";};
      toolbar = {animation = "slide-down";};
    };
  };
}
