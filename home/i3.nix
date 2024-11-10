{
  pkgs,
  config,
  lib,
  ...
}: {
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraConfig = ''
      exec --no-startup-id ${pkgs.i3wsr}/bin/i3wsr
    '';
    config = rec {
      modifier = "Mod4";
      defaultWorkspace = "workspace 1";
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec kitty";
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "${modifier}+Shift+e" = "exec rofi -show p -modi p:rofi-power-menu";
        "${modifier}+d" = "exec rofi -show drun -show-icons -terminal kitty";
        "Print" = "exec --no-startup-id rofi-screenshot";
        "Shift+Print" = "exec --no-startup-id rofi-screenshot -s";
        "${modifier}+l" = "exec --no-startup-id betterlockscreen --lock blur";
        "${modifier}+z" = "exec --no-startup-id rofi-rbw";
        "${modifier}+Shift+quotedbl" = "kill";
        "${modifier}+q" = "exec --no-startup-id dunstctl close";
        "${modifier}+n" = "exec --no-startup-id dunstctl history-pop";
        "${modifier}+Tab" = "exec rofi -show window";
      };
      gaps = {
        smartBorders = "on";
        smartGaps = true;
        inner = 5;
        outer = 0;
      };
      floating.border = 1;
      window = {
        titlebar = false;
        hideEdgeBorders = "both";
        border = 1;
        commands = [
          {
            criteria.class = "lxqt-openssh-askpass";
            command = "floating enable";
          }
          {
            criteria.class = "^KeePassXC$";
            command = "floating enable";
          }
          {
            criteria.class = "vokoscreenNG|Thunar|arandr|mpv|vlc|btop|SimpleScreenRecorder|qBittorrent";
            command = "floating enable";
          }
          {
            criteria.class = ".shutter-wrapped";
            command = "floating enable";
          }
          {
            criteria.title = "Playwright Inspector";
            command = "floating enable";
          }
        ];
      };
      bars = lib.mkForce [
        {
          id = "bar-0";
          hiddenState = "hide";
          position = "top";
          trayPadding = 5;
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${config.programs.i3status-rust.package}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-top.toml";
          fonts = {
            size = 12.0;
          };
          colors = {
            background = "#24273AE6";
            focusedWorkspace = {
              background = "#434C5EF6";
              border = "#434C5EE6";
              text = "#D8DEE9";
            };
            activeWorkspace = {
              background = "#4C566AE6";
              border = "#434C5EE6";
              text = "#D8DEE9";
            };
            inactiveWorkspace = {
              background = "#2E3440E6";
              border = "#434C5EE6";
              text = "#D8DEE9";
            };
            urgentWorkspace = {
              background = "#BF616AF6";
              border = "#434C5EE6";
              text = "#D8DEE9";
            };
          };
        }
      ];
    };
  };
}
