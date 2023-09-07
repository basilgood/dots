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
        names = ["monospace 10"];
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute" = "exec --no-startup-id wpctl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id wpctl set-source-mute @DEFAULT_SOURCE@ toggle";
        "${modifier}+Shift+e" = "exec rofi -show p -modi p:rofi-power-menu";
        "${modifier}+d" = "exec rofi -show drun -show-icons -terminal alacritty";
        "Print" = "exec --no-startup-id ${pkgs.rofi-screenshot}/bin/rofi-screenshot";
        "Shift+Print" = "exec --no-startup-id ${pkgs.rofi-screenshot}/bin/rofi-screenshot -s";
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
          criteria.class = "vokoscreenNG|Thunar";
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
            names = ["monospace"];
            size = 12.0;
          };
          colors = {
            background = "#1e1e1e";
          };
        }
      ];
    };
  };
}
