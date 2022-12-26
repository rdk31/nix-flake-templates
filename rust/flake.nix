{
  description = "Rust flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, crane, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          inherit (pkgs) lib;

          craneLib = crane.lib.${system};
          src = craneLib.cleanCargoSource ./.;

          buildInputs = with pkgs; [
            openssl
            pkg-config
          ];

          cargoArtifacts = craneLib.buildDepsOnly {
            inherit src buildInputs;
          };

          crate = craneLib.buildPackage {
            inherit cargoArtifacts src buildInputs;
          };
        in
        {
          checks = {
            inherit crate;

            crateClippy = craneLib.cargoClippy {
              inherit cargoArtifacts src buildInputs;
              cargoClippyExtraArgs = "--all-targets -- --deny warnings";
            };

            crateFmt = craneLib.cargoFmt {
              inherit src;
            };
          };

          packages.default = crate;

          apps.default = flake-utils.lib.mkApp {
            drv = crate;
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = builtins.attrValues self.checks;

            nativeBuildInputs = with pkgs; [
              cargo
              rustc
            ];
          };
        });
}
