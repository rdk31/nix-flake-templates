{
  description = "My awesome Python project";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      python = "python39";
    in 
      flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            pythonEnv = pkgs.${python}.withPackages (ps: with ps; [
              # python packages
              numpy
            ]);
          in {
            devShell = pkgs.mkShell {
              buildInputs = with pkgs; [
                pythonEnv
                python39Packages.autopep8
                pyright
              ];
            };
          }
        );
}
