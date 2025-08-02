{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
    ];
    # fontconfig.defaultFonts = pkgs.lib.mkForce {
    #   serif = [
    #     "Noto Serif CJK SC"
    #     "Noto Serif"
    #   ];
    #   sansSerif = [
    #     "Noto Sans CJK SC"
    #     "Noto Sans"
    #   ];
    #   monospace = [ "JetBrains Mono" ];
    #   emoji = [ "Noto Color Emoji" ];
    # };
  };
}
