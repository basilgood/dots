{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  programs = {
    neovim = {
      enable = true;
      package = inputs.neovim-nightly.packages."x86_64-linux".neovim;
      # extraLuaPackages = ps: [ps.magick];
      extraPackages = with pkgs; [
        nixd
        nixfmt-rfc-style
        tree-sitter
        #   statix
        vscode-langservers-extracted
        shfmt
        #   yamllint
        gojq
        #   fixjson
        #   gcc
        #   imagemagick
      ];
    };
  };
}
