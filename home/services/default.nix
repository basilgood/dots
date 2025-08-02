{ pkgs, ... }:
{
  imports = [
    ./picom.nix
    ./dunst.nix
    ./gammastep.nix
    # ./xidlehook.nix
    ./shutter.nix
    ./gromit.nix
  ];
  services.syncthing.enable = true;
  services.playerctld.enable = true;
  services.parcellite = {
    enable = true;
    package = pkgs.clipit;
  };
}
