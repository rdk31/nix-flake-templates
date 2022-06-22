{
  description = "Nix flake templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust flake";
      };

      python-app = {
        path = ./python/app;
        description = "Python application flake";
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
        description = "LaTeX flake";
      };
    };
  };
}
