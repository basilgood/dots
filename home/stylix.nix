{
  pkgs,
  ...
}:
{
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
    light = "Papirus-Dark";
  };
  # stylix.targets.ghostty.enable = false;
  # stylix.targets.btop.enable = false;
  # stylix.targets.dunst.enable = false;
  # stylix.targets.tmux.enable = true;
  stylix.cursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 20;
  };
  stylix.polarity = "dark";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    sizes.applications = 10;
    sizes.desktop = 8;
    sizes.popups = 10;
    sizes.terminal = 14;
  };

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;

}
