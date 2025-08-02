{ pkgs, ... }:
{
  # services.xidlehook = {
  #   enable = true;
  #   detect-sleep = true;
  #   not-when-audio = true;  # TODO: true when xidlehook will support pipewire
  #   not-when-fullscreen = true;
  #   timers = [
  #     {
  #       delay = 300;
  #       command = ''
  #         ${pkgs.libnotify}/bin/notify-send "Locking screen in 1 min"'';
  #       canceller = ''
  #         ${pkgs.libnotify}/bin/notify-send "Locking screen cancelled"'';
  #     }
  #     {
  #       delay = 30;
  #       command = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
  #       canceller = "";
  #     }
  #     {
  #       delay = 1200;
  #       command = "systemctl -i suspend";
  #     }
  #   ];
  # };
  services.xidlehook = {
    enable = true;
    not-when-audio = true;
    not-when-fullscreen = true;
    timers = [
      {
        delay = 300;
        command = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 20%";
        canceller = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 50%";
      }
      {
        delay = 600;
        command = "${pkgs.brightnessctl}/bin/brightnessctl --quiet set 50%; ${pkgs.i3lock}/bin/i3lock -c 000000; ${pkgs.xorg.xset}/bin/xset dpms force off";
        canceller = "";
      }
    ];
  };
}
