# Python Flake for Pip

## Usage

To run the flake:

- Run `nix develop`

**Setting up virtual environment automatically**:
Uncomment the `shellHook` if you want to create a virtual environment automatically when using `nix develop`.
When you uncomment this, you should also update the packages that should be installed with pip.

**Using dynamically linked libraries**:
Uncomment the `LD_LIBRARY_PATH` stuff.
