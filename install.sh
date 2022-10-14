#!/bin/sh

set -e

echo "Beginning installation of spicetify-transparent"
echo "https://github.com/sandarutharuneth/spicetify-transparent"

printf "\nPress any key to continue or Ctrl+C to cancel"
read -sn1 < /dev/tty
printf "\n\n"

# Check if $spicePath\Themes\transparent directory exists
spicePath="$(dirname "$(spicetify -c)")"
themePath="$spicePath/Themes/transparent"
if [ -d "$themePath" ]; then
    rm -rf "$themePath"
fi

# Download latest master
zipUri="https://github.com/sandarutharuneth/spicetify-transparent/archive/refs/heads/master.zip"
zipSavePath="/tmp/transparent-main.zip"
echo "Downloading transparent-spicetify latest master..."
curl --fail --location --progress-bar "$zipUri" --output "$zipSavePath"

# Extract theme from .zip file
echo "Extracting..."
unzip -q "$zipSavePath" -d "$spicePath"
mv "$spicePath/spicetify-transparent-main/" "$themePath"

# Delete .zip file
echo "Deleting zip file..."
rm "$zipSavePath"

# Link the transparent.js to the Extensions folder
mkdir -p "$spicePath/Extensions"
[[ -f "$spicePath/Extensions/transparent.js" ]] && rm "$spicePath/Extensions/transparent.js"
ln -sf "../Themes/transparent/transparent.js" "$spicePath/Extensions/transparent.js" 
echo "+ Installed transparent.js extension"

# Apply the theme with spicetify config calls
spicetify config extensions transparent.js
spicetify config current_theme transparent
spicetify config color_scheme dark
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
echo "+ Configured Transparent theme"

# Patch the xpui.js for sidebar fixes
# credit: https://github.com/JulienMaille/dribbblish-dynamic-theme/blob/main/install.sh
PATCH='[Patch]
xpui.js_find_8008 = ,(\\w+=)32,
xpui.js_repl_8008 = ,\${1}58,'
if cat "$spicePath/config-xpui.ini" | grep -o '\[Patch\]'; then
    perl -i -0777 -pe "s/\[Patch\].*?($|(\r*\n){2})/$PATCH\n\n/s" "$spicePath/config-xpui.ini"
else
    echo -e "\n$PATCH" >> "$spicePath/config-xpui.ini"
fi
echo "+ Patched xpui.js for Sidebar fixes"

spicetify apply
echo "+ Applied Theme"
