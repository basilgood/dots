{pkgs, ...}: {
  imports = [
    ./i3.nix
    ./i3status.nix
    ./rofi.nix
    ./services
    ./gtk.nix
    ./xdg.nix
    ./bash.nix
    ./tmux.nix
    ./git.nix
    ./yazi.nix
    ./zk.nix
  ];

  home = {
    username = "vasy";
    homeDirectory = "/home/vasy";
    packages = with pkgs; [
      obs-studio
      shotcut
      vim-full
      anydesk
      element-desktop
      docker-compose
      arion
      inkscape
      keepassxc
      thunderbird
      nextcloud-client
      freetube
      betterlockscreen
      arandr
      pciutils
      pavucontrol
      ryujinx
      rofi-power-menu
      xclip
      lm_sensors
      fd
      duf
      ytfzf
      nb
      simplescreenrecorder
      vokoscreen-ng
      telegram-desktop
      newsraft
      amberol
      xfce.thunar
      broot
      zathura
      imv
      qimgv
      autorandr
      timewarrior
    ];

    stateVersion = "23.11";
  };

  fonts.fontconfig.enable = true;
  programs = {
    neovim = {
      enable = true;
      extraLuaPackages = ps: [ps.magick];
      extraPackages = with pkgs; [
        vscode-langservers-extracted
        shfmt
        yamllint
        jq
        fixjson
        gcc
        imagemagick
      ];
    };
    brave.enable = true;
    chromium.enable = true;
    feh.enable = true;
    btop = {
      enable = true;
      catppuccin = {enable = true;};
    };
    mpv = {
      enable = true;
      config = {
        ytdl-format = "bestvideo+bestaudio";
      };
      scripts = [
        pkgs.mpvScripts.uosc
      ];
      bindings = {
        "Alt+0" = "set window-scale 0.5";
        "F3" = "cycle keepaspect";
        "F4" = "cycle-values panscan 1 0";
        "F10" = "cycle-values video-rotate 90 180 270 0";
      };
    };
    eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
      ];
    };
    ripgrep.enable = true;
    ripgrep.arguments = ["--pretty"];
    fzf.enable = true;
    fzf.defaultOptions = ["--height 40%" "--layout=reverse" "--ansi"];
    fzf.defaultCommand = "fd -tf -L -H -E=.git -E=node_modules --strip-cwd-prefix";
    fzf.tmux.enableShellIntegration = true;
    direnv.enable = true;
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };
    home-manager.enable = true;
    alacritty = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrainsMono NF";
          };
          size = 14;
        };
        env = {
          TERM = "xterm-256color";
        };
      };
    };
    kitty = {
      enable = true;
      catppuccin = {enable = true;};
      font = {
        # name = "JetBrainsMono Nerd Font";
        # package = pkgs.hack-font;
        name = "Iosevka Term";
        size = 14.0;
      };
      shellIntegration.mode = "no-cursor";
      settings = {
        term = "xterm-256color";
        scrollback_lines = 10000;
        cursor_shape = "block";
        cursor_blink_interval = 0;
        disable_ligatures = "never";
        adjust_line_height = "110%";
      };
    };
    aria2 = {
      enable = true;
      settings = {
        dir = "\${HOME}/Downloads/aria2";
        follow-torrent = false;
        peer-id-prefix = "";
        user-agent = "";
        summary-interval = "0";
      };
    };
  };

  home.sessionVariables = rec {
    VISUAL = "nvim";
    EDITOR = VISUAL;
    NIX_LD_LIBRARY_PATH = with pkgs;
      lib.makeLibraryPath [
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        cairo
        cups
        curl
        dbus
        expat
        egl-wayland
        fontconfig
        freetype
        fuse3
        gdk-pixbuf
        glib
        gtk3
        gtk4
        icu
        libGL
        libappindicator-gtk3
        libdrm
        libglvnd
        libnotify
        libpulseaudio
        libunwind
        libusb1
        libuuid
        libxkbcommon
        libxml2
        mesa
        nspr
        nss
        openssl
        pango
        pipewire
        stdenv.cc.cc
        systemd
        vulkan-loader
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXrender
        xorg.libXtst
        xorg.libxcb
        xorg.libxkbfile
        xorg.libxshmfence
        zlib
      ];
  };
}
