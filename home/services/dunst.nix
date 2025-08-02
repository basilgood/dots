{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "300x30-5+60";
        origin = "bottom-right";
        format = "%a\n<b>%s</b>\n%b";
        word_wrap = true;
        icon_position = "left";
        max_icon_size = 80;
        padding = 8;
        horizontal_padding = 8;
        line_height = 0;
        notification_height = "0";
        separator_height = 2;
        frame_width = 1;
        markup = "full";
        plain_text = "no";
        alignment = "center";
        vertical_alignment = "center";
      };
    };
  };
  home.packages = [ pkgs.libnotify ];
}
