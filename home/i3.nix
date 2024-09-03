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
    config = rec {
      modifier = "Mod4";
      window.border = 0;
      window.titlebar = false;
      gaps = {
        inner = 2;
        outer = 0;
      };
      fonts = {
        names = ["JetBrainsMono Nerd Font"];
        size = 11.0;
      };
      # i3 colors
      colors = {
        focused = {
          border = "#f5c2e7";
          background = "#f5c2e7";
          text = "#1e1e2e";
          indicator = "#f5c2e7";
          childBorder = "#f5c2e7";
        };
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec kitty";
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "${modifier}+Shift+e" = "exec rofi -show p -modi p:rofi-power-menu";
        "${modifier}+d" = "exec rofi -show drun -show-icons -terminal kitty";
        "${modifier}+l" = "exec --no-startup-id betterlockscreen --lock blur";
        "${modifier}+z" = "exec --no-startup-id ${pkgs.keepmenu}/bin/keepmenu";
        "${modifier}+Shift+quotedbl" = "kill";
        "${modifier}+q" = "exec --no-startup-id dunstctl close";
        "${modifier}+n" = "exec --no-startup-id dunstctl history-pop";
      };
      window.commands = [
        {
          criteria.class = "lxqt-openssh-askpass";
          command = "floating enable";
        }
        {
          criteria.class = "^KeePassXC$";
          command = "floating enable";
        }
        {
          criteria.class = "vokoscreenNG|Thunar|arandr|mpv|btop|SimpleScreenRecorder";
          command = "floating enable";
        }
        {
          criteria.title = "Playwright Inspector";
          command = "floating enable";
        }
      ];
      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }
      ];
      bars = lib.mkForce [
        {
          id = "bar-0";
          hiddenState = "hide";
          position = "bottom";
          trayPadding = 5;
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${config.programs.i3status-rust.package}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-bottom.toml";
          command = "i3bar";
          fonts = {
            names = ["JetBrainsMono Nerd Font"];
            size = 12.0;
          };
          # bar colors
          colors = {
            background = "#1e1e2e";
            statusline = "#cdd6f4";
            focusedWorkspace = {
              border = "#b4befe";
              background = "#f5c2e7";
              text = "#1e1e2e";
            };
            activeWorkspace = {
              border = "#b4befe";
              background = "#5f676a";
              text = "#cdd6f4";
            };
            inactiveWorkspace = {
              border = "#6c7086";
              background = "#302d41";
              text = "#cdd6f4";
            };
            urgentWorkspace = {
              border = "#eba0ac";
              background = "#fab387";
              text = "#1e1e2e";
            };
          };
        }
      ];
    };
  };
}
