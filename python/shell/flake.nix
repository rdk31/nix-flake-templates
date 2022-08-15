{
  description = "Python shell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    mach-nix.url = "github:davhau/mach-nix";
    # pypi-deps-db = {
    #   url = "github:davhau/pypi-deps-db/0000000000000000000000000000000000000000";
    #   flake = false;
    # };
    # mach-nix.inputs.pypi-deps-db.follows = "pypi-deps-db";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, mach-nix, flake-utils, ... }:
    let
      pythonVersion = "python39";
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mach = mach-nix.lib.${system};

        pythonEnv = mach.mkPython {
          python = pythonVersion;
          requirements = builtins.readFile ./requirements.txt;
        };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          packages = [ pythonEnv ];

          shellHook = ''
            export PYTHONPATH="${pythonEnv}/bin/python"
          '';
        };
      }
    );
}
