{
  pkgs,
  lib,
  ...
}:
let
  rofiThemes = pkgs.fetchFromGitHub {
    owner = "undiabler";
    repo = "nord-rofi-theme";
    rev = "eebddcbf36052e140a9af7c86f1fbd88e31d2365";
    sha256 = "sha256-n/3O6WdMUImCcrS5UBXoWHZevYhmC8WkA+u+ETU2m1M=";
  };
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    location = "center";
    font = lib.mkForce "DejaVu Sans 14";
    extraConfig = {
      modi = "drun,run,window,calc,emoji";
      show-icons = true;
      display-drun = "";
      drun-display-format = "{name}";
      sidebar-mode = false;
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
    theme = lib.mkForce "${rofiThemes}/nord.rasi";
  };

  home.packages = [
    (pkgs.rofi-screenshot.overrideAttrs (oa: {
      postFixup = ''
        wrapProgram $out/bin/${oa.pname} \
          --set PATH ${
            with pkgs;
            lib.makeBinPath [
              libnotify
              slop
              ffcast
              ffmpeg
              xclip
              rofi
              coreutils
              gnused
              procps
              gawk
            ]
          }
      '';
    }))
  ];
}
