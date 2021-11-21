{
  description = "My awesome Python project";
  nixConfig.bash-prompt = "\[python\]$ ";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      pythonVersion = "python39";
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          python = pkgs.${pythonVersion};
          pythonPackages = pkgs.${pythonVersion + "Packages"};

          pythonEnv = python.withPackages (p: with p; [
            # python dependencies
          ]);
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
