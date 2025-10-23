{
  inputs,
  outputs,
  lib,
  pkgs,
  ...
}:
let
  # default, rei, ken, silvia, catppuccin-[latte,...,mocha]
  sddm-theme = inputs.silent-sddm.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in
{
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
    };
    tmp.cleanOnBoot = true;
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    initrd.luks.devices."luks-b675c297-b740-4ca1-a651-4757592a5548".device =
      "/dev/disk/by-uuid/b675c297-b740-4ca1-a651-4757592a5548";
    kernelPackages = pkgs.linuxPackages_latest; # _zen, _hardened, _rt, _rt_latest, etc.

    # Silent boot
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;
    settings = {
      flake-registry = "";
      experimental-features = [
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
      trusted-users = [
        "root"
        "vasy"
        "@wheel"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  networking = {
    hostName = "liberty";
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
    };
    extraHosts = ''
      127.0.0.1 local.cosmoz.com
    '';
    wg-quick.interfaces.wg0.configFile = "/home/vasy/.config/vasile.conf";
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  system.activationScripts.copyFiles = {
    text = ''
      cp -r ${./assets}/* /var/lib/AccountsService/icons/
    '';
  };

  qt.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;

      package = pkgs.kdePackages.sddm;

      theme = sddm-theme.pname;

      extraPackages = sddm-theme.propagatedBuildInputs;

      settings = {
        General = {
          GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=1.2,QML2_IMPORT_PATH=${sddm-theme}/theme/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };

        Wayland = {
          EnableHiDPI = true;
        };

        Theme = {
          CursorTheme = "Bibata-Original-Ice";
          CursorSize = 24;
        };
      };
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users.vasy.imports = [
      ../../home-manager/vasy
      ./home.nix
      ./hypr.nix
    ];
  };

  users = {
    users.vasy = {
      home = "/home/vasy";
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "wheel"
        "disk"
        "audio"
        "video"
        "networkmanager"
        "systemd-journal"
        "scanner"
        "lp"
        "adbusers"
        "lxc"
        "lxd"
        "docker"
        "podman"
      ];
      initialPassword = "1234";
    };
    groups.vasy = {
      gid = 1000;
    };
  };

  fonts = {
    packages = with pkgs; [
      liberation_ttf
      nerd-fonts.caskaydia-cove
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-lgc-plus
      noto-fonts-monochrome-emoji
      inter
      times-newer-roman
    ];
    fontconfig.defaultFonts = {
      monospace = [ "CaskaydiaCove NF" ];
      sansSerif = [ "Inter" ];
      serif = [ "Times Newer Roman" ];
    };
  };

  environment.sessionVariables.XCURSOR_THEME = "Bibata-Modern-Ice";

  environment.systemPackages = with pkgs; [
    bibata-cursors
    clapper
    discord
    gnome-calculator
    gnome-disk-utility
    gnome-system-monitor
    gpu-screen-recorder-gtk
    mission-center
    nautilus
    obs-studio
    sddm-theme
    sddm-theme.test
    bibata-cursors
  ];

  # environment.pathsToLink = [ "/share/zsh" ];
  # environment.shells = [ pkgs.zsh ];
  # environment.enableAllTerminfo = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.dconf.enable = true;
  programs.seahorse.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  programs.uwsm.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.nix-ld.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-generations 1";
    flake = "/home/vasy/Projects/dots";
  };

  services.gvfs.enable = true;

  systemd.tmpfiles.rules = [
    "L /var/lib/AccountsService/icons/vasy - - - - ${./assets/rezero.png}"
  ];

  systemd = {
    services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerSocket.enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [
          "--filter-until=24h"
          "--filter=label!=important"
        ];
      };
    };
    # vmware.host.enable = true;
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  system.stateVersion = "24.05";
}
