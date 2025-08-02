{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];
  xdg = {
    enable = true;
    mime.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "gtk";
    };
  };
}
