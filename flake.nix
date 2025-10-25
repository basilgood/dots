{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    minimal-tmux.url = "github:niksingh710/minimal-tmux-status";
    minimal-tmux.inputs.nixpkgs.follows = "nixpkgs";

    silent-sddm.url = "github:uiriansan/silentsddm";
    silent-sddm.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-shell.url = "github:caelestia-dots/shell";
    # caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    betterfox.url = "github:yokoffing/BetterFox";
    betterfox.flake = false;

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";
  };

  outputs =
    { self, ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem =
        { system, ... }:
        let
          pkgs = inputs.nixpkgs.legacyPackages.${system};
        in
        {
          packages.hello = pkgs.hello;

          devShells.default = pkgs.mkShell {
            packages = [ pkgs.nixfmt-rfc-style ];
          };
        };

      flake = {
        nixosConfigurations.liberty = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            outputs = self.outputs;
          };
          modules = [
            (inputs.import-tree.filter (
              path:
              !(inputs.nixpkgs.lib.hasSuffix "home.nix" path || inputs.nixpkgs.lib.hasSuffix "hypr.nix" path)
            ) ./nixos)
          ];
        };

        homeConfigurations.vasy = inputs.home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs;
            outputs = self.outputs;
          };
          modules = [
            (inputs.import-tree [
              ./home-manager/vasy
              ./nixos/core/home.nix
              ./nixos/core/hypr.nix
            ])
          ];
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    };
}
