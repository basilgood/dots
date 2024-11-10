{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:danth/stylix";
    # nix-ld-rs = {
    #   url = "github:nix-community/nix-ld-rs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    catppuccin,
    stylix,
    neovim-nightly,
    home-manager,
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
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.vasy.imports = [
                ./home
                # catppuccin.homeManagerModules.catppuccin
                stylix.homeManagerModules.stylix
              ];
              users.vasy.home.packages = [
                neovim-nightly.packages.${system}.neovim
              ];
            };
          }
        ];
      };
    };
  };
}
