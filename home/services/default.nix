{pkgs, ...}:
{
  imports = [
    ./picom.nix
    ./dunst.nix
    ./gammastep.nix
    ./xidlehook.nix
  ];
  services.syncthing.enable = true;
}
