{
  description = "LaTeX template flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, flake-utils }:
    let
      rootName = "document";
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-small latex-bin latexmk
            metafont
            chktex
            latexindent
            ;
        };
      in
      rec {
        packages = {
          document = pkgs.stdenvNoCC.mkDerivation rec {
            name = rootName;
            src = self;
            buildInputs = [ pkgs.coreutils tex ];
            phases = [ "unpackPhase" "buildPhase" "installPhase" ];
            buildPhase = ''
              export PATH="${pkgs.lib.makeBinPath buildInputs}";
              mkdir -p .cache/texmf-var
              env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
                latexmk -interaction=nonstopmode -pdf ${rootName}.tex
            '';
            installPhase = ''
              mkdir -p $out
              cp ${rootName}.pdf $out/
            '';
          };
          default = packages.document;
        };

        devShells.default = pkgs.mkShellNoCC {
          buildInputs = [
            tex
          ];
        };
      });
}
