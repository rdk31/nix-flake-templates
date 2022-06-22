{
  description = "Python application flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    mach-nix.url = "github:davhau/mach-nix";
    # inputs.pypi-deps-db = {
    #   url = "github:davhau/pypi-deps-db/0000000000000000000000000000000000000000";
    #   flake = false;
    # };
    # inputs.mach-nix.inputs.pypi-deps-db.follows = "pypi-deps-db";

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

        pythonApp = mach.buildPythonApplication ./.;
        pythonAppEnv = mach.mkPython {
          python = pythonVersion;
          requirements = builtins.readFile ./requirements.txt;
        };
        pythonAppImage = pkgs.dockerTools.buildLayeredImage {
          name = pythonApp.pname;
          contents = [ pythonApp ];
          config.Cmd = [ "${pythonApp}/bin/main" ];
        };
      in
      rec
      {
        packages = {
          image = pythonAppImage;

          pythonPkg = pythonApp;
          default = packages.pythonPkg;
        };

        apps.default = {
          type = "app";
          program = "${packages.pythonPkg}/bin/main";
        };

        devShells.default = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            pythonAppEnv
            black
            pyright
          ];
        };
      }
    );
}
