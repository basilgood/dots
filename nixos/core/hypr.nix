{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];

  programs.caelestia = {
    enable = true;
    settings = {
      general = {
        apps = {
          terminal = [ "kitty" ];
          audio = [ "pavucontrol" ];
          playback = [ "mpv" ];
          explorer = [ "files" ];
        };
      };
    };
    cli = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings =
      let
        theme = {
          name = config.gtk.theme.name;
          cursor = {
            name = config.gtk.cursorTheme.name;
            size = toString config.gtk.cursorTheme.size;
          };
        };
      in
      {
        "$mod" = "SUPER";
        "$terminal" = "${pkgs.kitty}/bin/kitty";

        monitor = [
          ",prefered,auto,auto"
        ];

        env = [
          "TERM, kitty"
          "EDITOR, nvim"
          "GTK_THEME, ${theme.name}"
          "XCURSOR_THEME, ${theme.cursor.name}"
          "XCURSOR_SIZE, ${theme.cursor.size}"
          "HYPRCURSOR_THEME, ${theme.cursor.name}"
          "HYPRCURSOR_SIZE, ${theme.cursor.size}"
          "QS_ICON_THEME, ${config.gtk.iconTheme.name}"
        ];

        exec-once = [
          "hyprctl setcursor ${theme.cursor.name} ${theme.cursor.size}"
        ];

        general = {
          layout = "dwindle";
          allow_tearing = false;
          gaps_in = 10;
          gaps_out = 20;
          border_size = 0;
          resize_on_border = true;
        };

        dwindle = {
          force_split = 2;
        };

        decoration = {
          rounding = 0;
          blur = {
            size = 7;
            passes = 2;
          };
          shadow = {
            range = 20;
            render_power = 2;
            color = "rgba(0,0,0, 0.9)";
            color_inactive = "rgba(0,0,0, 0.6)";
          };
        };

        animation = [
          "workspaces, 1, 5, ease_out_quint, slide"
          "windows, 0"
          "layers, 0"
          "fade, 0"
          "border, 0"
          "borderangle, 0"
        ];
        bezier = "ease_out_quint, 0.22, 1, 0.36, 1";

        misc = {
          vrr = 0;
          focus_on_activate = true;
          disable_autoreload = true;
          disable_hyprland_logo = true;
          key_press_enables_dpms = true;
          mouse_move_enables_dpms = true;
          new_window_takes_over_fullscreen = 2;
        };

        bind = [
          # General
          "$mod, return, exec, $terminal"
          "$mod SHIFT, q, killactive"
          "$mod SHIFT, e, exec, sleep 0.1 && wlogout"
          "$mod, D, exec, caelestia shell drawers toggle launcher"
          "$mod, L, exec, caelestia shell lock lock"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          "$mod SHIFT, SPACE, togglefloating"
          "$mod, u, focusurgentorlast"
          "$mod, tab, focuscurrentorlast"
          "$mod, f, fullscreen"
          "$mod, M, exec, caelestia shell drawers toggle sidebar"

          # Screen resize
          "$mod CTRL, h, resizeactive, -20 0"
          "$mod CTRL, l, resizeactive, 20 0"
          "$mod CTRL, k, resizeactive, 0 -20"
          "$mod CTRL, j, resizeactive, 0 20"

          # Workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move to workspaces
          "$mod SHIFT, 1, movetoworkspace,1"
          "$mod SHIFT, 2, movetoworkspace,2"
          "$mod SHIFT, 3, movetoworkspace,3"
          "$mod SHIFT, 4, movetoworkspace,4"
          "$mod SHIFT, 5, movetoworkspace,5"
          "$mod SHIFT, 6, movetoworkspace,6"
          "$mod SHIFT, 7, movetoworkspace,7"
          "$mod SHIFT, 8, movetoworkspace,8"
          "$mod SHIFT, 9, movetoworkspace,9"
          "$mod SHIFT, 0, movetoworkspace,10"

          # Navigation
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Moving windows
          "$mod SHIFT, left,  swapwindow, l"
          "$mod SHIFT, right, swapwindow, r"
          "$mod SHIFT, up,    swapwindow, u"
          "$mod SHIFT, down,  swapwindow, d"

          # Screen capture
          ", Print, exec, caelestia screenshot" # Fullscreen screenshot
          "$mod, Print, global, caelestia:screenshot"
          "$mod SHIFT, Print, global, caelestia:screenshotFreeze"

          # Inhibit suspend
          ", F12, exec, caelestia shell idleInhibitor toggle"

          # Reload configuration
          "$mod SHIFT, R, exec, hyprctl reload"

          ", XF86MonBrightnessUp  , exec, caelestia shell brightness set +0.1"
          ", XF86MonBrightnessDown, exec, caelestia shell brightness set 0.1-"
          ", XF86AudioRaiseVolume , exec, ${pkgs.pamixer}/bin/pamixer -i 10"
          ", XF86AudioLowerVolume , exec, ${pkgs.pamixer}/bin/pamixer -d 10"
          ", XF86AudioMute        , exec, ${pkgs.pamixer}/bin/pamixer -t"
          ", XF86AudioMicMute     , exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"
          ", XF86KbdBrightnessUp  , exec, ${pkgs.brightnessctl}/bin/brightnessctl -d asus::kbd_backlight set +1"
          ", XF86KbdBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl -d asus::kbd_backlight set 1-"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindel = [
          ",XF86AudioRaiseVolume,  exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute,      exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        xwayland = {
          force_zero_scaling = true;
        };

        windowrule = [
          "float,class:^(vlc)$"
          "float,class:^(mpv)$"
          "float,class:^(motrix)$"
          "float,class:^(thunar)$"
          "float,class:qt5ct"
          "float,class:^(org.pulseaudio.pavucontrol)$"
          "float,class:^(com.saivert.pwvucontrol)$"
          "float,class:^(nm-connection-editor)$"
          "float,class:blueman-manager"
          "float,class:org.kde.polkit-kde-authentication-agent-1"
          "float,title:Picture-in-Picture"
          "float,class:^(org.keepassxc.KeePassXC)$"
          "float,class:kitty,title:btop"
          "float,class:firefox,title:(.*)(- Bitwarden)"
          "float,class:xsensors"
          "float,title:Blanket"
          "float,class:Bitwarden"
        ];

        windowrulev2 = [
          "noborder, onworkspace:w[t1]"
          "workspace 5 silent,  class:^Element$"
          "workspace 9 silent,  class:^thunderbird$"
          "workspace 10 silent,  class:^org.telegram.desktop$"
        ];
      };

    systemd.enable = false;
  };
}
