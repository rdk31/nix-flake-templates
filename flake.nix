{
  description = "Nix flake templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust development flake";
      };

      python-shell = {
        path = ./python/shell;
        description = "Python devShell flake";
      };

      python-jupyter = {
        path = ./python/jupyter;
        description = "Python jupyter flake";
      };
    };
  };
}
