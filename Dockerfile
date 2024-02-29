FROM cgr.dev/chainguard/jre:latest-dev

RUN wget -O /tmp/CrushFTP10.zip https://www.crushftp.com/early10/CrushFTP10.zip
RUN cd /tmp \
    && unzip CrushFTP10.zip \
    && rm /tmp/CrushFTP10/crushftp_init.sh \
    && rm /tmp/CrushFTP10/*.exe \
    && rm /tmp/CrushFTP10/CrushFTP.command \
    && rm /tmp/CrushFTP10/install_readme_macos.txt \
    && rm /tmp/CrushFTP10/install_readme_windows.txt \
    && rm /tmp/CrushFTP10/install_readme_linux.txt \
    && rm -rf /tmp/CrushFTP10/OSX_scripts


FROM cgr.dev/chainguard/jre:latest
# Pull datetime from build-arg for use in OCI labels
ARG RFC_DATE_TIME
ARG VERSION
ENV VERSION $VERSION
ENV DATE_TIME $RFC_DATE_TIME
# RUN export VERSION=$(java -jar CrushFTP10/CrushFTP.jar -version)

# Add some OCI labels
LABEL org.opencontainers.image.vendor="CrushFTP, LLC"
LABEL org.opencontainers.image.title="CrushFTP10"
LABEL org.opencontainers.image.version=$VERSION
LABEL org.opencontainers.image.description="Image for CrushFTP10 Server"
LABEL org.opencontainers.image.created=$DATE_TIME
LABEL org.opencontainers.image.os="wolfi"
LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jre"

COPY --from=0 --chown=java:java /tmp/CrushFTP10/ /app
# # WITHOUT BUILD KIT:
# COPY --chown=java:java entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# Default exposed ports
EXPOSE 8080
EXPOSE 443
EXPOSE 9090

# USER java # 65532
WORKDIR /app/CrushFTP10

ENTRYPOINT ["java", "-Ddir=/app/CrushFTP10", "-Xmx512M", "-jar", "plugins/lib/CrushFTPJarProxy.jar", "-d"]
