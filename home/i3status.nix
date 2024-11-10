{pkgs, ...}: {
  programs.i3status-rust = {
    enable = true;

    bars.top = {
      settings = {
        theme = {
          theme = "native";
          overrides = {
            idle_bg = "none";
          #   idle_fg = "#cdd6f4";
          };
        };
      };
      icons = "material-nf";
      blocks = [
        {
          block = "battery";
          if_command = "ls /sys/class/power_supply/BAT*";
        }
        {
          block = "notify";
          format = " $icon {($notification_count.eng(w:1)) |}";
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "load";
          format = " $icon $1m ";
          interval = 1;
        }
        {
          block = "memory";
          format = " $icon $mem_used.eng(w:2) ";
          format_alt = " $icon_swap $swap_used.eng(w:3,u:B,p:M) ";
          interval = 1;
        }
        {
          block = "temperature";
          format = " $icon $max ";
          interval = 10;
          chip = "k10temp-*";
        }
        {
          block = "sound";
          click = [
            {
              button = "left";
              cmd = "pavucontrol";
            }
          ];
        }
        {
          block = "time";
          click = [
            {
              button = "left";
              cmd = "${pkgs.xfce.orage}/bin/orage";
            }
          ];
          format = {
            full = " $icon $timestamp.datetime(f:'%a %d-%m-%Y %R', l:ro_RO) ";
            short = " $icon $timestamp.datetime(f:%R) ";
          };
          interval = 60;
        }
      ];
    };
  };
}
