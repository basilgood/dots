{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];
  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "gtk";
    };
    configFile."mimeapps.list".force = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    mimeApps = {
      enable = true;
      defaultApplications = let
        browser = "brave.desktop";
        editor = "nvim.desktop";
        mpv = "mpv.desktop";
        photo = "qimgv.desktop";
      in {
        "application/json" = [editor];
        "text/*" = [editor];
        "text/html" = [browser];
        "application/pdf" = ["org.pwmt.zathura.desktop"];
        "x-scheme-handler/discord" = ["discord.desktop"];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop "];
        "audio/*" = mpv;
        "video/*" = mpv;
        "image/*" = photo;
      };
    };
  };
}
