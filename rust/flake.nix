{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";

    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, crane, fenix, ... }:
    let
      rustVersion = "complete"; # stable, complete, beta & more... see https://github.com/nix-community/fenix
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          craneLib = crane.lib.${system}.overrideToolchain
            fenix.packages.${system}.${rustVersion}.toolchain;

          src = craneLib.cleanCargoSource (craneLib.path ./.);

          buildInputs = with pkgs; [
            # openssl
            # pkg-config
          ];

          cargoArtifacts = craneLib.buildDepsOnly {
            inherit src buildInputs;
          };

          crate = craneLib.buildPackage {
            inherit cargoArtifacts src buildInputs;
          };
        in
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          devenv.shells.default = {
            name = "my-project";

            # https://devenv.sh/reference/options/
            packages = buildInputs;

            languages.rust = {
              enable = true;
              version = rustVersion;
            };

            pre-commit.hooks = {
              nixpkgs-fmt.enable = true;
              clippy.enable = true;
              rustfmt.enable = true;
            };
          };

          packages.default = crate;
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
        };

      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
