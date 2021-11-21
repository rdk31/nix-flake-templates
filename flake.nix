{
  description = "Nix flake templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "A rust development flake";
      };

      python-simple = {
        path = ./python/simple;
        description = "A simple python devShell flake";
      };

      python-jupyter = {
        path = ./python/jupyter;
        description = "A python jupyter devShell flake";
      };
    };
  };
}
