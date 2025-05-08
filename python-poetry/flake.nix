{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        poetry2nix.url = "github:nix-community/poetry2nix";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, poetry2nix, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system: 
        let
            pkgs = nixpkgs.legacyPackages.${system};

            # --- SETTINGS ---
            environment = {
                projectDir = self;
                python = pkgs.python312;
            };
            # --- END OF SETTINGS ---
        in
            {
            packages = let
                inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;
            in {
                default = mkPoetryApplication environment;
            };

            devShells = let
                inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryEnv;
            in {
                default = pkgs.mkShellNoCC {
                    packages = with pkgs; [
                        (mkPoetryEnv environment)
                        poetry
                    ];
                };
            };
        });
}
