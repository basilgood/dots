{
  pkgs,
  ...
}: let
  rofiThemes = pkgs.fetchFromGitHub {
    owner = "newmanls";
    repo = "rofi-themes-collection";
    rev = "a1bfac5627cc01183fc5e0ff266f1528bd76a8d2";
    sha256 = "sha256-0/0jsoxEU93GdUPbvAbu2Alv47Uwom3zDzjHcm2aPxY=";
  };
in {
  programs.rofi = {
    enable = true;
    font = "monospace 14";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    plugins = with pkgs; [rofi-top rofi-calc rofi-emoji];
    location = "center";
    extraConfig = {
      modi = "drun,run,window,calc,emoji";
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
    theme = "${rofiThemes}/themes/squared-nord.rasi";
  };
}
