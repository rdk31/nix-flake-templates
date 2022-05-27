{
  description = "My awesome Python project";
  nixConfig.bash-prompt = "\[python\]$ ";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.mach-nix.url = "github:davhau/mach-nix";
  # inputs.pypi-deps-db = {
  #   url = "github:davhau/pypi-deps-db/0000000000000000000000000000000000000000";
  #   flake = false;
  # };
  # inputs.mach-nix.inputs.pypi-deps-db.follows = "pypi-deps-db";

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }:
    let
      pythonVersion = "python39";
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mach = mach-nix.lib.${system};

          pythonEnv = mach.mkPython {
            python = pythonVersion;
            requirements = builtins.readFile ./requirements.txt;
            # packagesExtra = [
            #   (mach.buildPythonPackage
            #     {
            #       src = builtins.fetchGit {
            #         url = "https://github.com/user/repo";
            #         ref = "branch";
            #         rev = "0000000000000000000000000000000000000000";
            #       };
            #     })
            # ];
          };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              pythonEnv
              black
              pyright
            ];
          };
        }
      );
}
