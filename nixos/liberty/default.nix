{ ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "liberty";

  services.xserver.videoDrivers = [ "amdgpu" ];
}
