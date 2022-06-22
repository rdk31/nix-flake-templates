# python-app

## Setting up

Rename `python_app` directory, name and main entrypoint in `setup.cfg`.

## Using

- running: `nix run`
- dev shell (for IDE): `nix develop`
- edit `setup.cfg` to add requirements (install_requires)
- edit `requirements.txt` for dev shell requirements

## Docker image

- build: `nix build .#image -o image`
- load to docker: `docker load < ./image`
