# Install tarball version of Floorp 

> [!DANGER]
> This forked version of the script is broken! Do not use! Use the orignal!

Note: This installation script is not affiliated with Floorp project or its 
maintainers in any way. If you encounter issues with this script, please 
report them at <https://github.com/coder0107git/floorp-install-script/issues>.

If you are on Ubuntu or an Ubuntu-derived system, please consider using the 
[offical Floorp PPA](https://docs.floorp.app/docs/installation/#gnulinux) 
instead of this script.

## Usage

```bash
git clone https://github.com/coder0107git/floorp-linux-install.git
cd floorp-linux-install
bash ./install.sh
```

To remove the application (if it has been installed with this method)
```bash
bash ./uninstall.sh
```

Future updates are already handled by Floorp, so you can delete this script 
after installation. If the install script doesn't work by the time you try 
it, please file an issue or open a PR.


## Details

This script installs Floorp to the following paths:

- ~/.tarball-installations/floorp
- ~/.local/bin/floorp
- ~/.local/share/applications/floorp.desktop


## Tested Distros

- Debian 12 by coder0107git

## Contributing

If you have a distro that you would like to add to the list of tested distros, please submit a pull request with any changes you may have made to the script and the distro you tested it on.
