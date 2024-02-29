#!/bin/sh
# set -e
# Move everything in /app into the /app/test folder

cp -r /app/* /app/CrushFTP10 2>/dev/null
rm -rf /app/CrushFTP10/CrushFTP10

cd /app/CrushFTP10

# Execute your Java command
java -Ddir=/app/CrushFTP10 -Xmx512M -jar /app/plugins/lib/CrushFTPJarProxy.jar -d
