_: {
  programs.kitty = {
    enable = true;
    font = {
      # package = pkgs.iosevka-comfy.comfy;
      # name = "Iosevka Comfy";
      # name = "JetBrains Mono";
      # package = pkgs.nerd-fonts.caskaydia-cove;
      # name = "CaskaydiaCove Nerd Font";
      # size = 16;
    };
    shellIntegration.mode = "no-cursor";
    settings = {
      # term = "xterm-256color";
      scrollback_lines = 10000;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      disable_ligatures = "never";
      # background_opacity = 0.8;
      # adjust_line_height = 4;
      # adjust_line_height = "110%";
    };
  };
}
