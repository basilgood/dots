{pkgs, ...}: {
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire.enable = true;

  environment.systemPackages = [
    pkgs.pavucontrol
    pkgs.pulsemixer
  ];
}
