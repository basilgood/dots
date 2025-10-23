{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    BROWSER = "brave";
    EDITOR = "nvim";
    TERMINAL = "kitty";
    NIX_LD_LIBRARY_PATH =
      with pkgs;
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
        libgbm
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
        # pipewire
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
        xorg.libpciaccess
        zlib
      ];
  };
}