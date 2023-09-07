{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./i3.nix
    ./i3status.nix
    ./rofi.nix
    ./services
    ./gtk.nix
    ./bash.nix
    ./tmux.nix
    ./git.nix
    ./lf.nix
  ];

  home = {
    username = "vasy";
    homeDirectory = "/home/vasy";
    packages = with pkgs; [
      anydesk
      element-desktop
      docker-compose
      arion
      inkscape
      vim_configurable
      keepassxc
      thunderbird
      xfce.thunar
      gnome.file-roller
      betterlockscreen
      arandr
      pciutils
      pavucontrol
      sonic-pi
      supercollider
      yuzu
      rofi-power-menu
      xclip
      fd
      lm_sensors
      duf
      ytfzf
      nb
      steam-run
      obs-studio
      vokoscreen-ng
      telegram-desktop
    ];

    stateVersion = "23.11";
  };

  fonts.fontconfig.enable = true;
  programs.brave.enable = true;
  programs.chromium.enable = true;
  programs.librewolf.enable = true;
  programs.feh.enable = true;
  programs.btop.enable = true;
  programs.mpv = {
    enable = true;
    bindings = {
      "F3" = "cycle keepaspect";
      "F4" = "cycle-values panscan 1 0";
      "F10" = "cycle-values video-rotate 90 180 270 0";
    };
  };
  programs.ripgrep.enable = true;
  programs.ripgrep.arguments = ["--pretty"];
  programs.fzf.enable = true;
  programs.fzf.defaultOptions = ["--height 40%" "--layout=reverse" "--ansi"];
  programs.fzf.defaultCommand = "fd -tf -L -H -E=.git -E=node_modules --strip-cwd-prefix";
  programs.fzf.tmux.enableShellIntegration = true;
  programs.direnv.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "TwoDark";
  };
  programs.home-manager.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
        };
        size = 14;
      };
      env = {
        TERM = "xterm-256color";
      };
    };
  };
  programs.aria2 = {
    enable = true;
    settings = {
      dir = "\${HOME}/Downloads/aria2";
      follow-torrent = false;
      peer-id-prefix = "";
      user-agent = "";
      summary-interval = "0";
    };
  };

  home.sessionVariables = rec {
    VISUAL = "nvim";
    EDITOR = VISUAL;
  };
}
