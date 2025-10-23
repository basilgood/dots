{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./neovim.nix
    ./bash.nix
    ./modules/packages.nix
    ./modules/programs.nix
    ./modules/session-variables.nix
  ];

  home = {
    username = "vasy";
    homeDirectory = "/home/vasy";
    stateVersion = "25.05";
  };
}
