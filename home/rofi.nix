{pkgs, ...}: let
  rofiThemes = pkgs.fetchFromGitHub {
    owner = "newmanls";
    repo = "rofi-themes-collection";
    rev = "a1bfac5627cc01183fc5e0ff266f1528bd76a8d2";
    sha256 = "sha256-0/0jsoxEU93GdUPbvAbu2Alv47Uwom3zDzjHcm2aPxY=";
  };
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    plugins = with pkgs; [rofi-top rofi-calc rofi-emoji];
    location = "center";
    font = "Raleway Regular 14";
    extraConfig = {
      modi = "drun,run,window,calc,emoji";
      show-icons = true;
      display-drun = "";
      drun-display-format = "{name}";
      sidebar-mode = false;
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
    theme = "${rofiThemes}/themes/spotlight-dark.rasi";
  };

  programs.rbw = {
    enable = true;
    settings = {
      email = "elsile691@gmail.com";
      pinentry = pkgs.pinentry-gtk2;
    };
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
    (pkgs.rofi-rbw-x11.overrideAttrs (oa: {
      patches =
        (oa.patches or [])
        ++ [
          (pkgs.fetchpatch {
            name = "fuzzel-support.patch";
            url = "https://github.com/natsukium/rofi-rbw/commit/12d53a06c8963b01f7f2b8b7728f514525050bc9.patch";
            includes = [
              "src/rofi_rbw/selector/fuzzel.py"
              "src/rofi_rbw/selector/selector.py"
            ];
            hash = "sha256-tb+lgsv5BRrh3tnHayKxzVASLcc4I+IaCaywMe9U5qk=";
          })
        ];
    }))
  ];
}
