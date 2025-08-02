_: {
  programs.i3status-rust = {
    enable = true;
    bars.top = {
      settings = {
        theme = {
          theme = "ctp-mocha";
          overrides = {
            separator = "";
          };
        };
      };
      icons = "material-nf";
      blocks = [
        {
          block = "toggle";
          format = "$icon 󰅶 ";
          command_state = "xset q | grep 'DPMS is Disabled'";
          command_on = "xset q -dpms s off";
          command_off = "xset q +dpms s on";
          state_on = "idle";
          state_off = "idle";
        }
        {
          block = "notify";
          format = " $icon {($notification_count.eng(w:1)) |}";
        }
        {
          block = "cpu";
          format = " $icon $utilization $frequency ";
        }
        {
          block = "load";
          format = " $icon $1m ";
        }
        {
          block = "memory";
          format = " $icon $mem_used.eng(w:2) ";
          format_alt = " $icon_swap $swap_used.eng(w:3,u:B,p:M) ";
        }
        {
          block = "temperature";
          format = " $icon $max ";
          interval = 10;
          chip = "k10temp-*";
        }
        {
          block = "custom";
          interval = 5;
          command = ''
            echo 󰈐 $(sensors | grep fan1 | awk '{print $2; exit}')
          '';
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
          format = {
            full = " $icon  $timestamp.datetime(f:'%a %d-%m-%Y %R', l:ro_RO) ";
          };
          interval = 60;
        }
      ];
    };
  };
}
