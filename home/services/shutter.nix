{ pkgs, ... }:
{
  systemd.user.services.shutter = {
    Unit = {
      Description = "Shutter";
      After = [
        "graphical-session-pre.target"
        "tray.target"
      ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.shutter}/bin/shutter --min_at_startup";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
