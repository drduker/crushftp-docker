#!/bin/sh
# set -e
# Move everything in /app into the /app/test folder


if [ -d "/app/CrushFTP10" ]; then
    echo "Local Volume Setup"
    echo "So that you can use live volume within same desktop folder"
    cp -r /app/* /app/CrushFTP10 2>/dev/null
    rm -rf /app/CrushFTP10/CrushFTP10

    cd /app/CrushFTP10
    java -jar CrushFTP.jar -a crushadmin password
    echo "Starting CrushFTP..."
    # Execute your Java command
    java -Ddir=/app/CrushFTP10/ -Xmx512M -jar /app/plugins/lib/CrushFTPJarProxy.jar -d
else
    echo "Shell exec run"
    mkdir -p /app/CrushFTP
    cp -r /app/ /app/CrushFTP/

    cd /app/CrushFTP
    java -jar CrushFTP.jar -a $CRUSHFTP_ADMIN_USERNAME $CRUSHFTP_ADMIN_PASSWORD
    # Execute your Java command
    java -Ddir=/app/CrushFTP/ -Xmx512M -jar /app/CrushFTP/plugins/lib/CrushFTPJarProxy.jar -d

fi
