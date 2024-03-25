#!/bin/bash


# Get latest crushftp build version, allow overriding with first arg
if [ -n "$1" ]; then
    echo "Version argument 1 is: $1"
    VERSION=${1}
else
    VERSION=$(wget -qO- https://www.crushftp.com/version11_build.html | head -n 1 | awk '{print $2}' | grep -v selected)
fi

# Check if the file already exists in the local directory
if [ -f "$VERSION.zip" ] ; then
    echo "Local file found. Unzipping..."
else
    echo "Local file not found. Downloading..."
    ls -lah
    wget -q -O $VERSION.zip https://www.crushftp.com/early${VERSION:0:2}/CrushFTP${VERSION:0:2}.zip
fi

echo "This is the version $VERSION"

cp $VERSION.zip /tmp/$VERSION.zip

cd /tmp \
&& unzip $VERSION.zip

# Remove unncessary files
rm /tmp/CrushFTP${VERSION:0:2}/crushftp_init.sh \
&& rm /tmp/CrushFTP${VERSION:0:2}/*.exe \
&& rm /tmp/CrushFTP${VERSION:0:2}/CrushFTP.command \
&& rm /tmp/CrushFTP${VERSION:0:2}/install_readme_macos.txt \
&& rm /tmp/CrushFTP${VERSION:0:2}/install_readme_windows.txt \
&& rm /tmp/CrushFTP${VERSION:0:2}/install_readme_linux.txt \
&& rm -rf /tmp/CrushFTP${VERSION:0:2}/OSX_scripts

pwd
ls -lah
