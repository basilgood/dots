{pkgs, ...}: {
  services.picom = {
    enable = true;
    package = pkgs.picom-next;
    backend = "glx";
    vSync = true;
    shadow = true;
    shadowExclude = ["window_type *= 'menu'" "name ~= 'Firefox$'" "name ~= 'Brave-browser$'" "focused = 1"];
    # Fading
    fade = true;
    fadeDelta = 10;
    settings = {
      animations = true;
      animation-stiffness-in-tag = 125;
      animation-stiffness-tag-change = 90.0;
      animation-window-mass = 0.4;
      animation-dampening = 15;
      animation-clamping = true;
      detect-transient = true;
      mark-wmwin-focused = true;
      #open windows
      animation-for-open-window = "zoom";
      #minimize or close windows
      animation-for-unmap-window = "squeeze";
      animation-for-transient-window = "slide-up"; #available options: slide-up, slide-down, slide-left, slide-right, squeeze, squeeze-bottom, zoom

      #set animation for windows being transitioned out while changings tags
      animation-for-prev-tag = "minimize";
      #enables fading for windows being transitioned out while changings tags
      enable-fading-prev-tag = true;

      #set animation for windows being transitioned in while changings tags
      animation-for-next-tag = "slide-in-center";
      #enables fading for windows being transitioned in while changings tags
      enable-fading-next-tag = true;
      blur = {
        method = "dual_kawase";
        strength = 8;
      };
      blur-background-exclude = [
        "class_g = 'slop'"
      ];
      popup_menu = {
        opacity = 1.0;
        shadow = false;
        full-shadow = false;
        focus = false;
      };
      corner-radius = 4;
      round-borders = 1;
    };
  };
}
