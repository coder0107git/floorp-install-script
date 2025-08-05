#!/usr/bin/env bash

set -euo pipefail

app_name=floorp
generic_tarball_installs_dir="$HOME/.tarball-installations"
app_directory="$generic_tarball_installs_dir/floorp"
app_symbolic_link="$HOME/.local/bin/$app_name"
app_desktop_file="$HOME/.local/share/applications/$app_name.desktop"
icon_path="$app_directory/browser/chrome/icons/default/default128.png"
executable_path="$app_directory/floorp"


echo "Welcome to Floorp tarball installer, just chill and wait for the installation to complete!"

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run as root. Exiting."
  exit 1
fi

sleep 1



echo "Checking to see if an older installation exists"

function delete_file_if_found {
  local file="$1"
  local msg_if_found="$2"

  if [ -f "$file" ]; then
    echo "$msg_if_found, removing..."

    # Pause to allow people to kill the script if wanted
    sleep 1

    rm "$file"
  fi
}
function delete_dir_if_found {
  local dir="$1"
  local msg_if_found="$2"

  if [ -f "$dir" ]; then
    echo "$msg_if_found, removing..."

    # Pause to allow people to kill the script if wanted
    sleep 1

    rm -rf "$dir"
  fi
}

delete_file_if_found "$app_symbolic_link" "Old Floorp symbolic link detected"
delete_dir_if_found "$app_directory" "Old app installation directory found"
delete_file_if_found "$app_desktop_file" "Old Floorp desktop file found"

sleep 1


if [ ! -d $generic_tarball_installs_dir ]; then
  echo "Creating the $generic_tarball_installs_dir directory for installation"
  mkdir $generic_tarball_installs_dir
fi


echo "Downloading and extracting the latest version of Floorp"
curl -sLS https://github.com/Floorp-Projects/Floorp/releases/download/latest/floorp-linux-amd64.tar.xz | \
  tar -xJv - -C "$app_directory"
if [ $? -eq 0 ]; then
  echo "Installed and untarred successfully"
else
  echo "Downloading or extracting Floorp failed. Please verify that curl is installed and that you can access $app_directory."
  exit 1
fi


ln -s $executable_path $app_symbolic_link
chmod u+x $app_symbolic_link
echo "Created a symbolic link to Floorp at $app_symbolic_link"



touch $app_desktop_file
echo "
[Desktop Entry]
Name=Floorp
Keywords=web;browser;internet
Exec=$executable_path %u
Icon=$icon_path
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
Categories=Network;WebBrowser;
Actions=new-window;new-private-window;profile-manager-window;
[Desktop Action new-window]
Name=Open a New Window
Exec=$executable_path --new-window %u
[Desktop Action new-private-window]
Name=Open a New Private Window
Exec=$executable_path --private-window %u
[Desktop Action profile-manager-window]
Name=Open the Profile Manager
Exec=$executable_path --ProfileManager
" >> $app_desktop_file

echo "Created desktop entry successfully"
sleep 1


echo "Installation completed successfully"
exit 0
