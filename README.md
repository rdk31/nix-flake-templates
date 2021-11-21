# nix-flake-templates

A collection of flake templates for easy project development and packaging.

## Supported environments

- Rust
- Python devShell
- Python jupyter

## Example usage

Intializing a rust project:

```
mkdir my-project && cd my-project
nix flake init -t "github:rdk31/nix-flake-templates/master#rust"
git init && git add .
```
