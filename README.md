# nix-flake-templates

A collection of flake templates for easy project development and packaging.

## Supported environments

- Rust
- Python shell
- Python jupyter
- LaTeX

## Example usage

Using rust template:

```
mkdir my-project && cd my-project
nix flake init -t "github:rdk31/nix-flake-templates/master#rust"
git init && git add -A
# change the name in flake.nix and Cargo.toml
nix develop
cargo run
```

Using python-shell template:

```
mkdir my-project && cd my-project
nix flake init -t "github:rdk31/nix-flake-templates/master#python-shell"
git init && git add -A
# add dependencies to requirements.txt
nix develop
python main.py
```

## Using flakes within a git repo without commiting flake.nix

- `git add --intent-to-add {flake.nix,flake.lock}`
- `git update-index --assume-unchanged {flake.nix,flake.lock}`

[source](https://discourse.nixos.org/t/can-i-use-flakes-within-a-git-repo-without-committing-flake-nix/)
