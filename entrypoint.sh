#!/bin/sh
# set -e
# Move everything in /app into the /app/test folder


if [ -d "/app/CrushFTP11" ]; then
    echo "Local Volume Setup"
    echo "So that you can use live volume within same desktop folder"
    cp -r /app/* /app/CrushFTP11 2>/dev/null
    rm -rf /app/CrushFTP11/CrushFTP11

    cd /app/CrushFTP11
    java -jar CrushFTP.jar -a crushadmin password
    echo "Starting CrushFTP..."
    # Execute your Java command
    java -Ddir=/app/CrushFTP11/ -Xmx512M -jar /app/plugins/lib/CrushFTPJarProxy.jar -ad ${CRUSHFTP_ADMIN_USERNAME:-crushadmin} ${CRUSHFTP_ADMIN_PASSWORD:-password}
else
    echo "Shell exec run"
    cd /app
    # java -jar CrushFTP.jar -a $CRUSHFTP_ADMIN_USERNAME $CRUSHFTP_ADMIN_PASSWORD
    # Execute your Java command
    java -Ddir=/app/ -Xmx512M -jar /app/plugins/lib/CrushFTPJarProxy.jar -ad ${CRUSHFTP_ADMIN_USERNAME:-crushadmin} ${CRUSHFTP_ADMIN_PASSWORD:-password}

fi
