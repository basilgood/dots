_: {
  # nix.nixPath = lib.mkForce [
  #   "nixpkgs=${inputs.nixpkgs}"
  # ];
  # nix.registry.nixos.flake = inputs.nixpkgs;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "vasy" "@wheel"];
  };
  system.stateVersion = "23.11";
}
