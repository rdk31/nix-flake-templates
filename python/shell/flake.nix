{
  description = "My awesome Python project";
  nixConfig.bash-prompt = "\[python\]$ ";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.mach-nix.url = "github:davhau/mach-nix";

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }:
    let
      pythonVersion = "python3";
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mach-nix-utils = import mach-nix
            {
              inherit pkgs;
              python = pythonVersion;
            };

          pythonEnv = mach-nix-utils.mkPython {
            requirements = builtins.readFile ./requirements.txt;
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