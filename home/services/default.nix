{pkgs, ...}: {
  imports = [
    ./picom.nix
    ./dunst.nix
    ./gammastep.nix
    ./xidlehook.nix
    ./shutter.nix
  ];
  services.syncthing.enable = true;
}
