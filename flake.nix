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
        description = "Python shell flake";
      };

      python-jupyter = {
        path = ./python/jupyter;
        description = "Python jupyter flake";
      };

      latex = {
        path = ./latex;
        description = "LaTeX template flake";
      };
    };
  };
}
