{pkgs, ...}: {
  services.xidlehook = {
    enable = true;
    detect-sleep = true;
    not-when-audio = true;  # TODO: true when xidlehook will support pipewire
    not-when-fullscreen = true;
    timers = [
      {
        delay = 300;
        command = ''
          ${pkgs.libnotify}/bin/notify-send "Locking screen in 1 min"'';
        canceller = ''
          ${pkgs.libnotify}/bin/notify-send "Locking screen cancelled"'';
      }
      {
        delay = 60;
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen --lock";
        canceller = "";
      }
      {
        delay = 300 + 1200;
        command = ''
          ${pkgs.libnotify}/bin/notify-send --urgency=critical "Sleeping in 1 min"'';
        canceller = ''
          ${pkgs.libnotify}/bin/notify-send "Sleep cancelled"'';
      }
      {
        delay = 60;
        command = "systemctl -i suspend";
      }
    ];
  };
}
