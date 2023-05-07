# nix-flake-templates

A collection of flake templates for easy project development and packaging.

## Supported templates

- `rust`
- `python-app` - python application
- `python-shell` - standalone scripts
- `latex`

## Example usage

Using rust template:

```
nix flake new -t "github:rdk31/nix-flake-templates/master#rust" my-project
git init && git add -A
# change the name in Cargo.toml
nix develop --impure
cargo run
# or just
nix run
```

## Using flakes within a git repo without commiting flake.nix

- `git add --intent-to-add {flake.nix,flake.lock}`
- `git update-index --assume-unchanged {flake.nix,flake.lock}`
