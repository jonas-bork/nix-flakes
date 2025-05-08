{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python39;
      in
      {
        devShell = pkgs.mkShell {
          packages = [
            python
            pkgs.virtualenv
          ];

          # ---- Automatically set up virtual environment ----
          # shellHook =
          #   let
          #     virtualEnvironmentDirectory = ".venv";
          #   in
          #   ''
          #     if [ ! -d "${virtualEnvironmentDirectory}" ]; then
          #       echo "Virtual environment (located in the ${virtualEnvironmentDirectory} directory) does not exist."
          #       echo "Creating virtual environment in the ${virtualEnvironmentDirectory} directory..."
          #       virtualenv -p="$(which python)" "${virtualEnvironmentDirectory}"
          #       echo "Virtual environment created in the ${virtualEnvironmentDirectory} diretory."
          #
          #       # Enter virtual environment and install packages
          #       source "${virtualEnvironmentDirectory}/bin/activate"
          #       pip install torch torchvision
          #       pip install "gymnasium[atari,accept-rom-license]==0.29.1"
          #       pip install opencv-python
          #       pip install imageio[ffmpeg]
          #       pip install matplotlib
          #     else
          #       echo "Entering the virtual environment located in the .venv directory"
          #       source "${virtualEnvironmentDirectory}/bin/activate"
          #     fi
          #   '';

          # ---- For dynamically linking libraries (if needed) ----
          # LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
          #   with pkgs;
          #   [
          #     zlib
          #     zstd
          #     stdenv.cc.cc
          #     curl
          #     openssl
          #     attr
          #     libssh
          #     bzip2
          #     libxml2
          #     acl
          #     libsodium
          #     util-linux
          #     xz
          #     systemd
          #     libGL
          #     glibc
          #     glib
          #   ]
          # );
        };
      }
    );
}
