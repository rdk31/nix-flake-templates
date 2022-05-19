{
  description = "My awesome Python project";
  nixConfig.bash-prompt = "\[python\]$ ";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.jupyterWith.url = "github:tweag/jupyterWith";

  outputs = { self, nixpkgs, flake-utils, jupyterWith, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          jupyter = jupyterWith.lib.${system};
          iPython = jupyter.kernels.iPythonWith {
            name = "python";
            packages = p: with p; [
              # numpy
            ];
          };

          jupyterEnvironment = jupyter.jupyterlabWith {
            kernels = [ iPython ];
          };
        in
        {
          devShell = pkgs.mkShell
            {
              buildInputs = [ jupyterEnvironment ];
              shellHook = ''
                jupyter lab
              '';
            };
        }
      );
}
