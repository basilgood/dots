{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/users.nix
    ../../modules/xorg.nix
    ../../modules/fonts.nix
    ../../modules/nix.nix
    ../../modules/wg.nix
    ../../modules/virtualisation.nix
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

  time.timeZone = "Europe/Bucharest";

  nixpkgs.config.allowUnfree = true;

  networking.useDHCP = false;
  networking.interfaces.enp8s0.useDHCP = true;
  networking.interfaces.wlp6s0.useDHCP = true;

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
  # services.flatpak.enable = true;
  services.gvfs.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  # };
  # sound.mediaKeys.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];
  # musnix.enable = true;
  services.xserver.config = ''
    Section "Monitor"
      Identifier "HDMI-A-0"
      Modeline "2560x1440R"  241.50  2560 2608 2640 2720  1440 1443 1448 1481 +hsync -vsync
      Option "PreferredMode" "2560x1440R"
    EndSection
  '';
}
