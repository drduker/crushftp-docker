#!/usr/bin/env sh
if [ "$INIT" = "true" ]; then # docker-compose.yaml - prod
    echo "INIT variable is true."
    # Check if the file exists
    if [ -f "/app/CrushFTP11/users/MainUsers/crushadmin/user.XML" ]; then
        echo "admin user already initialized"
        exit 0
    else
        continue
    fi
    echo "Only copies files over before start"
    echo "Local Volume Setup"
    echo "So that you can use live volume within same desktop folder"
    tr -dc '[:alnum:]' < /dev/urandom | head -c 16 > ${PASSFILE}
    cp -r /app/* /app/CrushFTP11 2>/dev/null
    rm -rf /app/CrushFTP11/CrushFTP11
    exit 0
elif [ -d "/app/CrushFTP11" ]; then #  dev
    echo "Local Volume Setup"
    echo "So that you can use live volume within same desktop folder"
    cp -r /app/* /app/CrushFTP11 2>/dev/null
    rm -rf /app/CrushFTP11/CrushFTP11
    cd /app/CrushFTP11
    echo "Starting CrushFTP..."
    # Execute your Java command
    java -Ddir=/app/CrushFTP11/ -Xmx512M -jar /app/CrushFTP11/plugins/lib/CrushFTPJarProxy.jar -ad ${CRUSHFTP_ADMIN_USERNAME:-crushadmin} ${CRUSHFTP_ADMIN_PASSWORD:-password}
else
    echo "Shell exec run" # docker-compose-dev.yaml - dev
    cd /app
    # java -jar CrushFTP.jar -a $CRUSHFTP_ADMIN_USERNAME $CRUSHFTP_ADMIN_PASSWORD
    # Execute your Java command
    java -Ddir=/app/ -Xmx512M -jar /app/plugins/lib/CrushFTPJarProxy.jar -ad ${CRUSHFTP_ADMIN_USERNAME:-crushadmin} ${CRUSHFTP_ADMIN_PASSWORD:-password}
fi
