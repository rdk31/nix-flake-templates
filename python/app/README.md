# python-app

## Setting up

Rename `python_app` directory, name and main entrypoint in `setup.cfg`.

## Using

- running: `nix run`
- dev shell (for IDE): `nix develop`
- edit `setup.cfg` to add requirements (install_requires)
- edit `requirements.txt` for dev shell requirements

### Docker image

- build: `nix build .#image -o image`
- load to docker: `docker load < ./image`

## Updating mach-nix pypi deps db

Add to inputs:

```nix
pypi-deps-db = {
  url = "github:davhau/pypi-deps-db/0000000000000000000000000000000000000000";
  flake = false;
};
mach-nix.inputs.pypi-deps-db.follows = "pypi-deps-db";
```

## Adding git dependency

Add to mkPython ([more info](https://github.com/DavHau/mach-nix/blob/master/examples.md)):

```nix
packagesExtra = [
  (mach.buildPythonPackage
    {
      src = builtins.fetchGit {
        url = "https://github.com/user/repo";
        ref = "branch";
        rev = "0000000000000000000000000000000000000000";
      };
    })
];
```
