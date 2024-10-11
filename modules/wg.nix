{lib, ...}: {
  networking.wg-quick.interfaces.wg0.configFile = "/home/vasy/.config/vasile.conf";
  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [];
}
