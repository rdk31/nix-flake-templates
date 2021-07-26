# nix-flake-templates

A collection of flake templates for easy project development and packaging.

## Supported environments

- Rust
- Python (simple - only devShell)

## Example usage

Intializing a rust project:

```
mkdir my-project && cd my-project
nix flake init -t "github:rdk31/nix-flake-templates#rust"
git init && git add .
```
