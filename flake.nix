{
  description = "Nix flake templates";

  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "A rust development flake";
      };
    };
  };
}
