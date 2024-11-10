{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      source-sans-pro
      source-serif-pro
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      jetbrains-mono
      fira-code
      lexend
      borg-sans-mono
      roboto
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "Noto"
          "FiraCode"
          "DroidSansMono"
          "Iosevka"
          "IosevkaTerm"
          "RobotoMono"
        ];
      })
    ];
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      serif = ["Source Serif Pro" "Noto Serif CJK SC" "Noto Serif"];
      sansSerif = ["Source Sans Pro" "Noto Sans CJK SC" "Noto Sans"];
      monospace = ["JetBrains Mono NF" "FiraCode Nerd Font Mono"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
