{
  description = "Simple Neovim Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "aarch64-darwin"; # Use "aarch64-darwin" for Apple Silicon Macs
      pkgs = nixpkgs.legacyPackages.${system};

      extraPackages = with pkgs; [
        nil # Nix LSP
        ty # python typechecker
        ruff # python linter and formatter
        lua-language-server
      ];

      # Define your custom Neovim
      myNeovim = pkgs.neovim.override {
        configure = {
          # Load your init.lua from the same directory
          customRC = ''
            luafile ${./init.lua}
          '';

          # Add plugins here from nixpkgs
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              tokyonight-nvim
              vim-nix
              mini-pick
              nvim-treesitter.withAllGrammars
              nvim-lspconfig
            ];
          };
        };
        extraMakeWrapperArgs = pkgs.lib.concatStringsSep " " [
          "--suffix" "PATH" ":" (pkgs.lib.makeBinPath extraPackages)
        ];

      };
    in
    {
      packages.${system}.default = myNeovim;
    };
}
