{pkgs, ...}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };

    settings = {
      global = {
        origin = "bottom-right";
        word_wrap = true;
        show_age_threshold = 60;
        idle_threshold = 120;
        padding = 20;
        horizontal_padding = 20;
        separator_height = 1;
        frame_width = 1;
        font = "Noto Sans 10";
        line_height = 4;
        max_icon_size = 32;
      };
      urgency_normal = {
        background = "#2a2a37";
      };
      urgency_critical = {
        background = "#2a2a37";
        frame_color = "#F38BA8";
      };
    };
  };

  home.packages = [pkgs.libnotify];
}