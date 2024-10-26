{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/users.nix
    ../../modules/xorg.nix
    # ../../modules/kde.nix
    ../../modules/fonts.nix
    ../../modules/nix.nix
    ../../modules/sound.nix
    ../../modules/wg.nix
    ../../modules/virtualisation.nix
    ../../modules/nix-ld.nix
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/sda2";
      preLVM = true;
    };
  };

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
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
  };
  programs.nm-applet.enable = true;

  time.timeZone = "Europe/Bucharest";
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs.dconf.enable = true;
  programs.ssh.startAgent = true;
  programs.ssh.extraConfig = ''
    Host *
      ControlMaster auto
      ControlPath ~/.ssh/sockets-%r@%h-%p
      ControlPersist 600
  '';
  programs.ssh = {
    askPassword = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
  };
  environment.localBinInPath = true;
  services.upower.enable = true;
  services.gvfs.enable = true;
  services.xserver.config = ''
    Section "Monitor"
      Identifier "HDMI-A-0"
      Modeline "2560x1440R"  241.50  2560 2608 2640 2720  1440 1443 1448 1481 +hsync -vsync
      Option "PreferredMode" "2560x1440R"
    EndSection
  '';
}
