# python-shell

## Using

- dev shell: `nix develop`
- edit `requirements.txt` for dev shell requirements

## Jupyter in VSCode

To use jupyter in VSCode add these requirements:

```
ipykernel
nbformat
ipywidgets
```

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
