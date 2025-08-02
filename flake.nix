{
  description = "dots";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      utils,
      stylix,
      # catppuccin,
      neovim-nightly,
      ...
    }@inputs:
    utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        modules = [
          ./hosts/liberty
          # catppuccin.nixosModules.catppuccin
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              # useGlobalPkgs = true;
              # useUserPackages = true;
              users.vasy.imports = [
                ./home
                # catppuccin.homeModules.catppuccin
                stylix.homeModules.stylix
              ];
              users.vasy.home.packages = [ neovim-nightly.packages.${system}.neovim ];
            };
          }
        ];
      in
      {
        nixosConfigurations = {
          liberty = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = modules;
          };
        };
      }
    );
}
