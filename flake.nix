{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib&ref=ac353e87aecf02315d82a3ad22725d2bc8140f0c";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    neovim-flake,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      liberty = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs self;};
        modules = [
          ./hosts/liberty
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vasy.imports = [
              ./home
            ];
            home-manager.users.vasy.home.packages = [
              neovim-flake.packages."${system}".neovim
            ];
          }
        ];
      };
    };
  };
}
