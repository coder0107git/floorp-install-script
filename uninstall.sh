#!/usr/bin/env bash

set -euo pipefail
application_name="floorp"


echo "Uninstalling Floorp"

rm -rf "$HOME/.tarball-installations/floorp"
rm $HOME/.local/bin/$application_name
rm $HOME/.local/share/applications/$application_name.desktop

echo "Uninstallation successfull"
